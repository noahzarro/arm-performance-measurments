# `app-template`

> Quickly set up a [`probe-run`] + [`defmt`] + [`flip-link`] embedded project
> running on the [`RTIC`] scheduler

[`probe-run`]: https://crates.io/crates/probe-run
[`defmt`]: https://github.com/knurling-rs/defmt
[`flip-link`]: https://github.com/knurling-rs/flip-link
[`RTIC`]: https://rtic.rs/

Based on https://github.com/knurling-rs/app-template

## Dependencies

#### 1. `flip-link`:

```console
$ cargo install flip-link
```

#### 2. `probe-run`:

``` console
$ # make sure to install v0.2.0 or later
$ cargo install probe-run
```
*Note:* You can also just clone this repository instead of using `cargo-generate`, but this involves additional manual adjustments.

## Setup

#### 1. Clone the repository

#### 2. Add the target with `rustup`.

``` console
$ rustup target add thumbv7m-none-eabi
```

## Run

#### Plug in the NUCLEO board

#### Run it with

``` console
$ DEFMT_LOG=debug cargo run
```

The `DEFMT_LOG` environment variable is used to set the log level. With setting it to debug, the measurement results can be seen.

## Toubleshooting

In my case, the IIS lab machines where not able to detect the board via USB. With my personal laptop it worked fine. See [probe run](https://github.com/knurling-rs/probe-run) for further information.

## License

Licensed under either of

- Apache License, Version 2.0 ([LICENSE-APACHE](LICENSE-APACHE) or
  http://www.apache.org/licenses/LICENSE-2.0)

- MIT license ([LICENSE-MIT](LICENSE-MIT) or http://opensource.org/licenses/MIT)

at your option.

### Contribution

Unless you explicitly state otherwise, any contribution intentionally submitted
for inclusion in the work by you, as defined in the Apache-2.0 license, shall be
licensed as above, without any additional terms or conditions.

[Knurling]: https://knurling.ferrous-systems.com
[Ferrous Systems]: https://ferrous-systems.com/
[GitHub Sponsors]: https://github.com/sponsors/knurling-rs
