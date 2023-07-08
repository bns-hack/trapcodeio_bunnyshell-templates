# Bunnyshell Template for fiber-vue-mongodb

This Environment [Template](https://documentation.bunnyshell.com/docs/templates-what-are-templates) is a boilerplate for
creating a new environment based on a stack using **GoLang** with **Fiber** for the backend,
**VueJs** with **Typescript** for the frontend and MongoDB as the database.

The template provides the Bunnyshell configuration composed of 3 Components (frontend + backend + database) and the CRUD
application that demonstrates how the components work together to form an environment.

You can extend the template by further adding Components, be them more APIs or other services, such as queues, caches,
block storage etc.

# Environment overview

An [Environment in Bunnyshell](https://documentation.bunnyshell.com/docs/environments) is a user-defined group that
brings together applications and all the services and databases those applications require.

This Environment Template contains 3 components:

- `app` for frontend, based on a `node` image
- `api` for backend, also based on a `golang` image
- `db` using a `mongodb` image

and 1 persistent volume:

- `data-volume`

## Container images

The images for both frontend and backend have 2 possible stages: `dev` and `prod`.

The `dev` stage is suitable for development, as it contains development packages and libraries and has debugging
enabled.  
The `prod` stage is meant for production/staging, as it produces an optimized image, as lightweight as possible.

The stage (`dev` or `prod`) can be set from the Environment's configuration (`bunnyshell.yaml`), within each
Component's `dockerCompose.build.target` property. The default is `dev`, and it can be changed to `prod` to produce
production-like images.

# How to use this Template

You can create Environments from
a [Bunnyshell Template](https://documentation.bunnyshell.com/docs/templates-what-are-templates); these Environments can
have multiple purposes:

- Development
- Staging / Dev testing / End-to-end testing

Development Environments should be created with the `dev` target for images (see "Container images") and can be used for
Remote Development.

Staging / Testing Environments should be created with the `prod` target for images, in order to have the application
running as it does in production.

## Staging / Testing

For staging / testing purposes, the Environments just need to be deployed.

You need to ensure that the `dockerCompose.build.target` is set to `prod` for all the Components, and
then [deploy the Environment](https://documentation.bunnyshell.com/docs/environment-workflows-deploy).

## Remote Development

[Remote Development](https://documentation.bunnyshell.com/docs/remote-development) allows you to develop directly in a
cloud environment, therefore eliminating all inconsistencies and approximations of traditional local environments.

The code is run in a container running in Kubernetes, and you can choose one of two ways to work, depending on whether you
prefer to keep a local copy of the code or not.

1. You can have the code existing **only in the container** - you will need an IDE capable of connecting via SSH to
   install a headless IDE in the container, e.g., VS Code or the JetBrains suite.

2. You can have the code existing **on your device** and it will be synchronized into the container, any IDE or plain
   text editor will do.

📖 For more information on how Remote Development works in Bunnyshell, please see
the [dedicated documentation](https://documentation.bunnyshell.com/docs/remote-development).

🧱 Remote Development can only be started from the CLI, so you will need
to [install the Bunnyshell CLI](https://documentation.bunnyshell.com/docs/bunnyshell-cli-install) installed and
to [authenticate in the CLI](https://documentation.bunnyshell.com/docs/bunnyshell-cli-authentication).



### Start a Remote Development session

In order to start a Remote Development session, you must run the dedicated command from the CLI:

```
bns remote-development up
```

The CLI will present a wizard, so you can choose your Environment first, then the Component on which you want to develop
on.  
You can also pass on the Component ID, to skip the wizard. The full command can be copied from the UI: go to the
Environment details screen, click the desired Component, then expand the *Component Actions* and select *Remote
Development*.

💡 When typing, you can use the shorter alias: `bns rdev up`

🧱 Please note that starting a Remote Development session requires the *Remote Development* setting to be *ON* for the
Environment (*ON* is the default value).

You need to choose the way you wish to work with files, before starting the Remote Development session.



#### Working with code from your machine

When working with code stored locally (the default mode), you just need to run:

```
bns remote-development up
```



You need to provide 2 additional paths:

- the *local path*, for your local code files
- the *remote path*: the path where code files are located within the container (you can find this out from
  the `Dockerfile`, it's in the `WORKDIR` statement); for the `api` application, it is `/usr/src/app`.

💡 The wizard will require these from you, but you can also provide them as options, `-l` and `-r` respectively.

After starting the Remote Development session, the Bunnyshell CLI opens a shell into the container. From it, you can run
any application-related command you would run on local.  

Please note that **you must start the application** manually, as you may need to start the application in a number of
ways, e.g., with or without debugging.

Also Note that in some cases when using `--sync-mode none` and vscode remote development, `go` may not be found. All you need todo is to add the `go` binary to your path:
```bash
export PATH=$PATH:/usr/local/go/bin
```

This should set the path for the current session. If you want to make it permanent, you can add it to your `.bashrc` file.


```
$ bns remote-development up --component {YOUR_COMPONENT_ID}
? Local Path {YOUR_OWN_LOCAL_PATH}}
? Remote Path /usr/src/app
/usr/src/app # bash dev.sh
```

`dev.sh` contains a script to start the application in development mode, with file watching using the `air` package.

📖 For more information on starting a remote Development session, please see:

- [How to Start Remote Development](https://documentation.bunnyshell.com/docs/remote-development-start)
    - [with local files](https://documentation.bunnyshell.com/docs/remote-development-local-files)


#### Working with code from the container

When working directly with the files from the container, you need to disable the synchronization of files, by adding the
option `--sync-mode none` to the command. Usually, since you'll be using your IDE to connect to the container, you will
also want to pass in `--no-tty`, to disable leaving an SSH terminal into the container, but this is optional and depends
on your preferences.

You need to provide the *remote path*: the path where code files are located within the container (you can find this out
from the `Dockerfile`, it's in the `WORKDIR` statement); for the `api` application, it is `/usr/src/app`.

💡 The wizard will require this from you, but you can also provide it as an option, using `-r`.

```
bns remote-development up --sync-mode none --no-tty
? Remote Path /usr/src/app
Pod is ready for Remote Development.
You can find the SSH Config file in /Users/myuser/.bunnyshell/remote-dev/ssh-config
```

💡 Remember that you can pass in the optional flag `--component {YOUR_COMPONENT_ID}` to skip running the wizard to choose
the Component.

Using the SSH config file, you can now configure your IDE to connect remotely to the container, via SSH.  
🚀 [See how to configure VS Code for Remote Development via SSH](https://documentation.bunnyshell.com/docs/remote-development-configure-vs-code-connection)

Please note that using the Terminal from the IDE, **you must start the application** manually, as you may need to start
the application in a number of ways, eg. with or without debugging.

```
/usr/src/app # bash dev.sh
```


📖 For more information on starting a remote Development session, please see:

- [How to Start Remote Development](https://documentation.bunnyshell.com/docs/remote-development-start)
    - [with remote files](https://documentation.bunnyshell.com/docs/remote-development-remote-files)



### Stop a Remote Development session

In order to stop a Remote Development session, you must run the dedicated command from the CLI:

```
bns remote-development down
```

The CLI will present a wizard, so you can choose your Environment first, then the Component for which you want to stop
the session for.  
You can also pass on the Component ID, to skip the wizard. The full command for starting a session can be copied from
the UI: go to the Environment details screen, click the desired Component, then expand the *Component Actions* and
select *Remote Development*. Then, you just need to replace `up` with `down.

```
 bns remote-development down --component {YOUR_COMPONENT_ID}
```

📖 For more information on stopping a remote Development session, please see:

- [Stop Remote Development](https://documentation.bunnyshell.com/docs/remote-development-stop)


#### Debugging frontend

Debugging frontend applications has a different approach than debugging backend applications, as it leverage the WDS (
Webpack Dev Server) technique for modern javascript frameworks.

You only need to configure your IDE for the Remote Environment, and this is a matter of following a few simple steps.

📖 For more information on debugging frontend applications, please see:

- [Debugging frontend apps](https://documentation.bunnyshell.com/docs/remote-development-debugging-frontend)

---

# Important Note

You must change all passwords and review all parameters to ensure that your Environment is secure.

