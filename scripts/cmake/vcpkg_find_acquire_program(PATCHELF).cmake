set(program_name patchelf)
if(CMAKE_HOST_SYSTEM_NAME STREQUAL "Linux")
    set(program_version 0.14.5)
    vcpkg_execute_in_download_mode(COMMAND "uname" "-m" OUTPUT_VARIABLE HOST_ARCH OUTPUT_STRIP_TRAILING_WHITESPACE)
    if(HOST_ARCH STREQUAL "aarch64")
        set(patchelf_platform "aarch64")
        set(download_sha512 "3B5EB4405FAB1D5202728AA390DD9F059CD7AFD582BAD9C50383CAD605127BC77DFCE3F2F26E9714F6BD5CCFFD49D3973BA2F061D2E2931B6E1BD0C263B99E75")
    elseif(HOST_ARCH STREQUAL "armv7l")
        set(patchelf_platform "armv7l")
        set(download_sha512 "30160d750784f5e8805bffe96ca80b40ed10441549e10f47b61e0d21b32979e01865cd770f1de9162988d4daabc6984dcdb7438f67bcd5eee76ad5f01b00276d")
    else()
        set(patchelf_platform "x86_64")
        set(download_sha512 "5E983A25B3F3F3B8582D1DE6C7DE30812E8D6E58E96F711F33A2634D3FB1F2370531DA179927AA401328319F92465E6F76274A6F994D1DC54C74B98E704D0D29")
    endif()
    set(download_filename "${program_name}-${program_version}-${patchelf_platform}.tar.gz")
    set(download_urls "https://github.com/NixOS/patchelf/releases/download/${program_version}/${download_filename}")
    set(tool_subdirectory "${program_version}-${patchelf_platform}-linux")
    set(paths_to_search "${DOWNLOADS}/tools/patchelf/${program_version}-${patchelf_platform}-linux/bin")
elseif(CMAKE_HOST_SYSTEM_NAME STREQUAL "Windows")
    set(patchelf_host "win32")
    set(program_version 0.18.0)
    set(download_sha512
"19d24f64bea6d6236292455a09695d289ddca71433a0ccaf372f57da80a4cde5db1c375ac8e29a41ac1f0676b7d3b56ce5b2baf39e58369c4f741b612db51044")
    set(download_filename "${program_name}-${patchelf_host}-${program_version}.exe")
    set(download_urls "https://github.com/NixOS/patchelf/releases/download/${program_version}/${download_filename}")
    set(tool_subdirectory "${program_version}-${patchelf_host}")
    set(paths_to_search "${DOWNLOADS}/tools/patchelf/${program_version}-${patchelf_host}/")
    set(raw_executable ON)
    set(rename_binary_to "patchelf.exe")
endif()
