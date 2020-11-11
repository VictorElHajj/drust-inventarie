FROM nixos/nix

COPY ./ /ihp
WORKDIR /ihp

# Add build dependencies
RUN nix-env -i git cachix direnv
RUN cachix use digitallyinduced

# Build
RUN nix-shell -j auto --cores 0 --command "make -B build/Generated/Types.hs"
RUN nix-shell -j auto --cores 0 --command "make -B .envrc"
RUN nix-shell -j auto --cores 0 --command "make static/prod.css static/prod.js"
RUN nix-shell -j auto --cores 0 --command "make build/bin/RunOptimizedProdServer"

# Run
CMD nix-shell -j auto --cores 0 --command "./build/bin/RunOptimizedProdServer"
