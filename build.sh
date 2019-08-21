#!/usr/bin/env bash

number_of_build_workers=8
bypass_vcpkg=true

if [[ "$OSTYPE" == "darwin"* ]]; then
  if [[ "$1" == "gcc" ]]; then
    export CC="/usr/local/bin/gcc-9"
    export CXX="/usr/local/bin/g++-9"
  fi
  vcpkg_triplet="x64-osx"
else
  vcpkg_triplet="x64-linux"
fi

if [[ ! -z "${VCPKG_ROOT}" ]] && [ -d ${VCPKG_ROOT} ] && [ ! "$bypass_vcpkg" = true ]
then
  vcpkg_path="${VCPKG_ROOT}"
  vcpkg_define="-DCMAKE_TOOLCHAIN_FILE=${vcpkg_path}/scripts/buildsystems/vcpkg.cmake"
  vcpkg_triplet_define="-DVCPKG_TARGET_TRIPLET=$vcpkg_triplet"
  echo "Found vcpkg in VCPKG_ROOT: ${vcpkg_path}"
elif [[ ! -z "${WORKSPACE}" ]] && [ -d ${WORKSPACE}/vcpkg ] && [ ! "$bypass_vcpkg" = true ]
then
  vcpkg_path="${WORKSPACE}/vcpkg"
  vcpkg_define="-DCMAKE_TOOLCHAIN_FILE=${vcpkg_path}/scripts/buildsystems/vcpkg.cmake"
  vcpkg_triplet_define="-DVCPKG_TARGET_TRIPLET=$vcpkg_triplet"
  echo "Found vcpkg in WORKSPACE/vcpkg: ${vcpkg_path}"
elif [ ! "$bypass_vcpkg" = true ]
then
  (>&2 echo "yolo_mark is unsupported without vcpkg, use at your own risk!")
fi

## DEBUG
#mkdir -p build_debug
#cd build_debug
#cmake .. -DCMAKE_BUILD_TYPE=Debug ${vcpkg_define} ${vcpkg_triplet_define} ${additional_defines} ${additional_build_setup}
#cmake --build . --target install -- -j${number_of_build_workers}
##cmake --build . --target install --parallel ${number_of_build_workers}  #valid only for CMake 3.12+
#cd ..

# RELEASE
mkdir -p build_release
cd build_release
cmake .. -DCMAKE_BUILD_TYPE=Release ${vcpkg_define} ${vcpkg_triplet_define} ${additional_defines} ${additional_build_setup}
cmake --build . --target install -- -j${number_of_build_workers}
#cmake --build . --target install --parallel ${number_of_build_workers}  #valid only for CMake 3.12+
cd ..

# In case you want to discard changes from examples, it's useful to run this command:
# git update-index --assume-unchanged data/img/air1.jpg data/img/air1.txt data/img/air2.jpg data/img/air2.txt data/img/air3.jpg data/img/air3.txt data/img/air4.jpg data/img/air4.txt data/img/air5.jpg data/img/air5.txt data/img/air6.jpg data/img/air6.txt data/img/bird1.jpg data/img/bird1.txt data/img/bird2.jpg data/img/bird2.txt data/img/bird3.jpg data/img/bird3.txt data/img/bird4.jpg data/img/bird4.txt data/obj.data data/obj.names data/train.txt

