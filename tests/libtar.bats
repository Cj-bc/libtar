#!/usr/bin/env bats

setup() {
  source libtar.sh
}

@test "Unpacking .tar" {
  raw_path="./tests/src/tar/raw/"
  tar_path="./tests/src/tar/tarred.tar"
  extracted_path=""
  Tar::Unpack "$tar_path" 'extracted_path'

  echo "extracted_path: ${extracted_path}" >&3
  run diff <(tree "${extracted_path}" | tail -n +2) <(tree "$raw_path" | tail -n +2) >&3
  [ "$status" -eq 0 ]
}

teadown() {
  rm -r "${extracted_path%/*}"
}
