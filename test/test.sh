ls -la

if [ ! -d "${{ github.workspace }}/example" ]; then
  echo: "FAIL: Please Add the EXAMPLES"
fi