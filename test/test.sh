set -e

if [ ! -d "examples" ]; then
  echo "FAIL: Please Add the EXAMPLES"
  exit 1
fi

if [ ! -d "examples/complete" ]; then
  echo "FAIL: Please Add the COMPLETE"
  exit 1
fi

if [ ! -d "examples/complete/tfvars" ]; then
  echo "FAIL: Please Add the TFVAR File"
  exit 1
fi