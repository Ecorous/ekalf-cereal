{ pkgs, inputs, ... }: {
  nixpkgs.overlays = [ inputs.fenix.overlays.default ];
  #nixpkgs.overlays = [ fenix.overlays.default ];
  environment.systemPackages = with pkgs;
    [
      (with fenix; combine [
        (complete.withComponents [
          "cargo"
          "clippy"
          "rust-src"
          "rustc"
          "rustfmt"
          "rust-analyzer"
          "llvm-tools-preview"
        ])
        targets.wasm32-unknown-unknown.latest.rust-std
      ])

      libssh2.dev
      openssl
      pkg-config
      #rust-analyzer-nightly
    ];
}
