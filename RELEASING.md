# Releasing the ECMIS skill

Pushing a `v*` tag builds `ecmis-skill-<version>.zip` with `packaging/build-ecmis-zip.sh` and attaches it
to a GitHub Release ([`.github/workflows/release-zip.yml`](.github/workflows/release-zip.yml)).

```sh
git tag v1.0.0
git push origin v1.0.0
```

- The leading `v` is stripped: tag `v1.0.0` → `ecmis-skill-1.0.0.zip`, and `VERSION` inside the zip reads `1.0.0`.
- A tag containing `-` (e.g. `v1.1.0-rc1`) is published as a pre-release.
- Release notes are generated from the commits since the previous tag.
- Re-running the workflow for the same tag replaces the zip on the existing release.

Download link to hand to users:
`https://github.com/teerut-mercil/ecmis-trace/releases/latest`

## Local build

```sh
bash packaging/build-ecmis-zip.sh            # dist/ecmis-skill-<yyyymmdd>-<sha>.zip
ECMIS_VERSION=1.0.0 bash packaging/build-ecmis-zip.sh   # same naming CI uses
```
