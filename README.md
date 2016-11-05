### Build system

Several gulp tasks are provided, which are described by running `gulp help`:

- typescript linting/compiling tasks (watch/watchAndServe/lint/tdd)
- server application + autorestart it when code changes (through [nodemon](https://www.npmjs.com/package/nodemon))
- run tests (jasmine/mocha + supertest included as examples)

## Installation

You can either run the project installing dependencies locally, or run a dockerized container that includes all dependencies

### Local

- Node must be installed on the system
- Run `npm install` from the root folder to install all required dev/build dependencies
- (Optionally) Install *Typescript definitions manager (tsd)* `npm install tsd -g` globally to update typescript definitions when desired

### Docker

You can use the included Dockerfile to build an image that provides node and npm installed by default, and points
 to the `gulp` command as the entrypoint. You can follow these steps

1. Build the docker image, w/ some tag: `docker build -t node-express-boilerplate`
2. Install npm dependencies if starting from scratch
  `docker run -t --rm -v /absolute/path/to/this/folder:/app --entrypoint="npm" node-express-boilerplate install`.

  You can also replace `install` by `any_npm_command` in the above
3. Run any gulp task from the project:
  `docker run -t --rm -v /absolute/path/to/this/folder:/app node-express-boilerplate <GULP_TASK_HERE>`

The docker container includes the *tsd* node package pre-installed, which you can run through
  `docker run -t --rm -v /absolute/path/to/this/folder:/app --entrypoint="tsd" node-express-boilerplate <TSD_COMMAND_HERE>`

##### Launching server on docker

Remember to map the port from the host to the container to be able to access the server.

`docker run -t --rm -p 3000:3000 -v /absolute/path/to/this/folder:/app node-express-boilerplate serve --port=3000`

## Developing

- Use the `gulp watchAndServe` task (or `docker run -t --rm -p 3000:3000 -v /absolute/path/to/this/folder:/app node-express-boilerplate watchAndServe --port=3000` when using the dockerized container)
during development to get hot code-reloading/test running when you modify your code

#### Running through docker container

The container image already contains PM2 globally. In order to launch the server, we need to use the wrapper script `serveCluster.sh`. It can be called by running

`docker run --rm -v /absolute/path/to/this/folder:/app -p 3000:3000 --name myRunningServer --entrypoint="bash"  node-express-boilerplate ./serveCluster.sh <PM2 OPTIONS HERE>`

where `<PM2 OPTIONS HERE>` can be any number of CLI options from the PM2 package, such as `--instances=4`, etc.

**Issuing commands to the cluster**

You can interact with the cluster running inside the container via PM2 using the following command

`docker exec myRunningServer pm2 <OPTIONS>`,

such as for example

`docker exec myRunningServer pm2 reload` or
`docker exec myRunningServer pm2 show 0`
