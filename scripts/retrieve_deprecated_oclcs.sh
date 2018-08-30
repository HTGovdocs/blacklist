export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/bin:$PATH"

# copy to /htdata
D=$(date +\%Y-\%m-\%d)
cp data/oclcs_removed_from_registry.txt /htdata/govdocs/feddocs_oclc_filter/oclcs_removed_from_registry_$D.txt

git commit data/oclcs_removed_from_registry.txt -m 'OCLC update' --author="Josh Steverman <jstever@umich.edu>"
