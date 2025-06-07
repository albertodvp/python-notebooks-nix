# Python notebooks nix

This repo contains some flake templates to easily setup python notebooks

## Base

Contains Jupyter notebook and some python packages installed from nixpkgs

```bash
nix flake init --template github:albertodvp/python-notebooks-nix
```

If you are using `direnv` you can simply run `direnv allow`.

If you are not:

```
git init
nix develop
```

To try the notebook:
```bash
jupyter notebook
```
