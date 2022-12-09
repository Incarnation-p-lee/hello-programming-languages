#! /bin/bash

function print_and_exit_if_error() {
    if [ ! $? -eq 0 ]; then
        echo "Error: $1"
        exit 1
    fi
}

function prepare() {
    wget http://riscv-sw-ci1.sh.intel.com/test/openvino/mobilenet.tar && \
        wget http://riscv-sw-ci1.sh.intel.com/test/openvino/car.bmp
    print_and_exit_if_error "Error: prepare model and data failed."

    tar xvf mobilenet.tar
    print_and_exit_if_error "Error: internal error of tar package."
}

function do_job() {
    export LD_LIBRARY_PATH=/opt/intel/openvino/bin/riscv64/Release/:$LD_LIBRARY_PATH
    export PATH=/opt/intel/samples/bin/:$PATH

    hello_classification ./public/mobilenet-v2-1.4-224/FP32/mobilenet-v2-1.4-224.xml \
                         ./car.bmp \
                         TEMPLATE
    print_and_exit_if_error "Error: OpenVINO example test failed."
}

function endup() {
    rm -rf public/
    rm car.bmp
    rm mobilenet.tar
}

#### Start

cd "$HOME" || exit

prepare
do_job
endup

#### End
