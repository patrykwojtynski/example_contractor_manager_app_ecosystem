# Example Contractor-Manager App Ecosystem
Two apps: Contractor App and Manager App communicate via Kafka.

Contractor App allows to create Payment Request and Manager App can accept or reject it's submission.

### Run with docker
Apples' Silicon support included :)

###### Build
`make build`

###### Bash
Contractor app: `make contractor_app_bash`
Manager app: `make manager_app_bash`

###### Test
`make test`

###### Start all components
First: `make dev_environment`
Then: `make up`

Visit
- `http://localhost:3333/` for Contractor App
- `http://localhost:3000/` for Manager App


# TODO:
- container names
- split Make commands