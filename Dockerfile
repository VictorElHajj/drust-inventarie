FROM nixos/nix

# Add build dependencies
RUN nix-env --quiet -iA nixpkgs.git nixpkgs.cachix nixpkgs.direnv
RUN cachix use digitallyinduced

COPY ./src /ihp
WORKDIR /ihp

# Build
RUN nix-shell -j auto --cores 0 --command "make -Bs .envrc"
RUN nix-shell -j auto --cores 0 --command "make static/prod.css static/prod.js"

RUN nix-shell -j auto --cores 0 --command "make build/bin/RunOptimizedProdServer"
# Run
CMD nix-shell -j auto --cores 0 --command "./build/bin/RunOptimizedProdServer"
