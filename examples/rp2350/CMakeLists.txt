cmake_minimum_required(VERSION 3.13)

if (NOT DEFINED ENV{PICO_SDK_PATH})
    message(FATAL_ERROR "Set PICO_SDK_PATH to your Pico SDK checkout")
endif()
include($ENV{PICO_SDK_PATH}/external/pico_sdk_import.cmake)

project(naegleria_rp2350 C CXX ASM)

set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)

pico_sdk_init()

set(BF_SOURCE "${CMAKE_CURRENT_LIST_DIR}/../hello.b" CACHE FILEPATH "Brainfuck source file")
set(BF_ASM "${CMAKE_CURRENT_BINARY_DIR}/brainfuck_riscv.S")

add_custom_command(
    OUTPUT ${BF_ASM}
    COMMAND /bin/sh -c "php \"${CMAKE_CURRENT_LIST_DIR}/../../bin/compile\" riscv \"${BF_SOURCE}\" > \"${BF_ASM}\""
    DEPENDS ${BF_SOURCE}
            ${CMAKE_CURRENT_LIST_DIR}/../../bin/compile
            ${CMAKE_CURRENT_LIST_DIR}/../../src/compiler.php
            ${CMAKE_CURRENT_LIST_DIR}/../../src/compiler/riscv.php
    VERBATIM
)

add_custom_target(generate_brainfuck_asm DEPENDS ${BF_ASM})

add_executable(naegleria_rp2350
    main.c
    ${BF_ASM}
)
add_dependencies(naegleria_rp2350 generate_brainfuck_asm)

target_link_libraries(naegleria_rp2350 pico_stdlib)

pico_enable_stdio_usb(naegleria_rp2350 1)
pico_enable_stdio_uart(naegleria_rp2350 1)

pico_add_extra_outputs(naegleria_rp2350)

find_program(PICOTOOL picotool)
if (PICOTOOL)
    add_custom_target(flash
        COMMAND ${PICOTOOL} load -f $<TARGET_FILE:naegleria_rp2350>
        COMMAND ${PICOTOOL} reboot
        DEPENDS naegleria_rp2350
        USES_TERMINAL
        COMMENT "Flashing naegleria_rp2350 via picotool"
    )
endif()
