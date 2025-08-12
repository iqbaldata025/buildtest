# K12RS ETL Sample (Windows CodeBuild)

This repository mirrors your Jenkins batch for packaging and uploading database/ETL artifacts, but runs in **AWS CodeBuild (Windows)**.

## What it does
1. Copies `K12RSIntegrationServices\DataIntegration` into `C:\DataBaseInstaller\Source_Packages\<ENV>\DataIntegration\`
2. Calls `C:\DataBaseInstaller\Build\run_database_installer.bat <ENV>` to produce `Final_Packages`
3. Stages a local `db-prepration-package` folder and uploads it to S3
4. Cleans up the local staging folder

## Build prerequisites
- **Windows CodeBuild** environment
- Role permissions: CloudWatch Logs, S3 RW to your bucket, (optional) VPC if you access private DBs
- (Optional) Create the S3 bucket path: `s3://k12rs-devops/build-packages/database-packages/`

## How to run
Use the provided `buildspec.yml`. Start a build and override environment variables if needed:
- `ENVNAME` → `dev` or `prod`
- `DATA_INTEGRATION_GIT_BRANCH` → branch name path in S3
- `S3_BUCKET` / `S3_PREFIX` if different

> If your CodeBuild image does **not** already contain `C:\DataBaseInstaller\Build\run_database_installer.bat`, keep it in this repo (it is included) and the build will copy it into `C:\DataBaseInstaller\Build` in `pre_build`.

## Repo layout
```
.
├── buildspec.yml
├── README.md
├── DataBaseInstaller
│   └── Build
│       └── run_database_installer.bat
└── K12RSIntegrationServices
    └── DataIntegration
        ├── jobs
        │   └── master.kjb
        └── transforms
            └── sample.ktr
```
