set(CMAKE_CXX_COMPILER "/nix/store/ndwb5w7v2v5a32ysrr4d8i2m77f8r2x8-aarch64-apple-darwin-clang-wrapper-16.0.6/bin/aarch64-apple-darwin-c++")
set(CMAKE_CXX_COMPILER_ARG1 "")
set(CMAKE_CXX_COMPILER_ID "Clang")
set(CMAKE_CXX_COMPILER_VERSION "16.0.6")
set(CMAKE_CXX_COMPILER_VERSION_INTERNAL "")
set(CMAKE_CXX_COMPILER_WRAPPER "")
set(CMAKE_CXX_STANDARD_COMPUTED_DEFAULT "17")
set(CMAKE_CXX_EXTENSIONS_COMPUTED_DEFAULT "ON")
set(CMAKE_CXX_STANDARD_LATEST "23")
set(CMAKE_CXX_COMPILE_FEATURES "cxx_std_98;cxx_template_template_parameters;cxx_std_11;cxx_alias_templates;cxx_alignas;cxx_alignof;cxx_attributes;cxx_auto_type;cxx_constexpr;cxx_decltype;cxx_decltype_incomplete_return_types;cxx_default_function_template_args;cxx_defaulted_functions;cxx_defaulted_move_initializers;cxx_delegating_constructors;cxx_deleted_functions;cxx_enum_forward_declarations;cxx_explicit_conversions;cxx_extended_friend_declarations;cxx_extern_templates;cxx_final;cxx_func_identifier;cxx_generalized_initializers;cxx_inheriting_constructors;cxx_inline_namespaces;cxx_lambdas;cxx_local_type_template_args;cxx_long_long_type;cxx_noexcept;cxx_nonstatic_member_init;cxx_nullptr;cxx_override;cxx_range_for;cxx_raw_string_literals;cxx_reference_qualified_functions;cxx_right_angle_brackets;cxx_rvalue_references;cxx_sizeof_member;cxx_static_assert;cxx_strong_enums;cxx_thread_local;cxx_trailing_return_types;cxx_unicode_literals;cxx_uniform_initialization;cxx_unrestricted_unions;cxx_user_literals;cxx_variadic_macros;cxx_variadic_templates;cxx_std_14;cxx_aggregate_default_initializers;cxx_attribute_deprecated;cxx_binary_literals;cxx_contextual_conversions;cxx_decltype_auto;cxx_digit_separators;cxx_generic_lambdas;cxx_lambda_init_captures;cxx_relaxed_constexpr;cxx_return_type_deduction;cxx_variable_templates;cxx_std_17;cxx_std_20;cxx_std_23")
set(CMAKE_CXX98_COMPILE_FEATURES "cxx_std_98;cxx_template_template_parameters")
set(CMAKE_CXX11_COMPILE_FEATURES "cxx_std_11;cxx_alias_templates;cxx_alignas;cxx_alignof;cxx_attributes;cxx_auto_type;cxx_constexpr;cxx_decltype;cxx_decltype_incomplete_return_types;cxx_default_function_template_args;cxx_defaulted_functions;cxx_defaulted_move_initializers;cxx_delegating_constructors;cxx_deleted_functions;cxx_enum_forward_declarations;cxx_explicit_conversions;cxx_extended_friend_declarations;cxx_extern_templates;cxx_final;cxx_func_identifier;cxx_generalized_initializers;cxx_inheriting_constructors;cxx_inline_namespaces;cxx_lambdas;cxx_local_type_template_args;cxx_long_long_type;cxx_noexcept;cxx_nonstatic_member_init;cxx_nullptr;cxx_override;cxx_range_for;cxx_raw_string_literals;cxx_reference_qualified_functions;cxx_right_angle_brackets;cxx_rvalue_references;cxx_sizeof_member;cxx_static_assert;cxx_strong_enums;cxx_thread_local;cxx_trailing_return_types;cxx_unicode_literals;cxx_uniform_initialization;cxx_unrestricted_unions;cxx_user_literals;cxx_variadic_macros;cxx_variadic_templates")
set(CMAKE_CXX14_COMPILE_FEATURES "cxx_std_14;cxx_aggregate_default_initializers;cxx_attribute_deprecated;cxx_binary_literals;cxx_contextual_conversions;cxx_decltype_auto;cxx_digit_separators;cxx_generic_lambdas;cxx_lambda_init_captures;cxx_relaxed_constexpr;cxx_return_type_deduction;cxx_variable_templates")
set(CMAKE_CXX17_COMPILE_FEATURES "cxx_std_17")
set(CMAKE_CXX20_COMPILE_FEATURES "cxx_std_20")
set(CMAKE_CXX23_COMPILE_FEATURES "cxx_std_23")
set(CMAKE_CXX26_COMPILE_FEATURES "")

set(CMAKE_CXX_PLATFORM_ID "Darwin")
set(CMAKE_CXX_SIMULATE_ID "")
set(CMAKE_CXX_COMPILER_FRONTEND_VARIANT "GNU")
set(CMAKE_CXX_SIMULATE_VERSION "")




set(CMAKE_AR "/nix/store/ndwb5w7v2v5a32ysrr4d8i2m77f8r2x8-aarch64-apple-darwin-clang-wrapper-16.0.6/bin/aarch64-apple-darwin-ar")
set(CMAKE_CXX_COMPILER_AR "CMAKE_CXX_COMPILER_AR-NOTFOUND")
set(CMAKE_RANLIB "/run/current-system/sw/bin/llvm-ranlib")
set(CMAKE_CXX_COMPILER_RANLIB "CMAKE_CXX_COMPILER_RANLIB-NOTFOUND")
set(CMAKE_LINKER "/nix/store/ndwb5w7v2v5a32ysrr4d8i2m77f8r2x8-aarch64-apple-darwin-clang-wrapper-16.0.6/bin/aarch64-apple-darwin-ld")
set(CMAKE_LINKER_LINK "")
set(CMAKE_LINKER_LLD "")
set(CMAKE_CXX_COMPILER_LINKER "NOTFOUND")
set(CMAKE_CXX_COMPILER_LINKER_ID "")
set(CMAKE_CXX_COMPILER_LINKER_VERSION )
set(CMAKE_CXX_COMPILER_LINKER_FRONTEND_VARIANT )
set(CMAKE_MT "")
set(CMAKE_TAPI "CMAKE_TAPI-NOTFOUND")
set(CMAKE_COMPILER_IS_GNUCXX )
set(CMAKE_CXX_COMPILER_LOADED 1)
set(CMAKE_CXX_COMPILER_WORKS TRUE)
set(CMAKE_CXX_ABI_COMPILED TRUE)

set(CMAKE_CXX_COMPILER_ENV_VAR "CXX")

set(CMAKE_CXX_COMPILER_ID_RUN 1)
set(CMAKE_CXX_SOURCE_FILE_EXTENSIONS C;M;c++;cc;cpp;cxx;m;mm;mpp;CPP;ixx;cppm;ccm;cxxm;c++m)
set(CMAKE_CXX_IGNORE_EXTENSIONS inl;h;hpp;HPP;H;o;O;obj;OBJ;def;DEF;rc;RC)

foreach (lang IN ITEMS C OBJC OBJCXX)
  if (CMAKE_${lang}_COMPILER_ID_RUN)
    foreach(extension IN LISTS CMAKE_${lang}_SOURCE_FILE_EXTENSIONS)
      list(REMOVE_ITEM CMAKE_CXX_SOURCE_FILE_EXTENSIONS ${extension})
    endforeach()
  endif()
endforeach()

set(CMAKE_CXX_LINKER_PREFERENCE 30)
set(CMAKE_CXX_LINKER_PREFERENCE_PROPAGATES 1)
set(CMAKE_CXX_LINKER_DEPFILE_SUPPORTED FALSE)

# Save compiler ABI information.
set(CMAKE_CXX_SIZEOF_DATA_PTR "8")
set(CMAKE_CXX_COMPILER_ABI "")
set(CMAKE_CXX_BYTE_ORDER "LITTLE_ENDIAN")
set(CMAKE_CXX_LIBRARY_ARCHITECTURE "")

if(CMAKE_CXX_SIZEOF_DATA_PTR)
  set(CMAKE_SIZEOF_VOID_P "${CMAKE_CXX_SIZEOF_DATA_PTR}")
endif()

if(CMAKE_CXX_COMPILER_ABI)
  set(CMAKE_INTERNAL_PLATFORM_ABI "${CMAKE_CXX_COMPILER_ABI}")
endif()

if(CMAKE_CXX_LIBRARY_ARCHITECTURE)
  set(CMAKE_LIBRARY_ARCHITECTURE "")
endif()

set(CMAKE_CXX_CL_SHOWINCLUDES_PREFIX "")
if(CMAKE_CXX_CL_SHOWINCLUDES_PREFIX)
  set(CMAKE_CL_SHOWINCLUDES_PREFIX "${CMAKE_CXX_CL_SHOWINCLUDES_PREFIX}")
endif()





set(CMAKE_CXX_IMPLICIT_INCLUDE_DIRECTORIES "/nix/store/0mjkx2zcq2wzd1wqx2d6xfb2mcvhg074-libcxx-16.0.6-dev/include;/nix/store/irdd5a4q2sgprl8cglgi9f4n6w1kp73c-compiler-rt-libc-16.0.6-dev/include;/nix/store/h36yb01kvdf2431abrlwphk8ax0ii4ds-libiconv-107-dev/include;/nix/store/bb3daz1v50731210bjrrci95zcsqc6p0-mcfgthread-x86_64-w64-mingw32-1.6.1-dev/include;/nix/store/xvx2qflrhvdds3ywbaahid827n56kwj4-libcxx-x86_64-apple-darwin-16.0.6-dev/include;/nix/store/1hxnghxiakprbm44p5a43rflfs943fjv-compiler-rt-libc-x86_64-apple-darwin-16.0.6-dev/include;/nix/store/8ng4rnckjpnvjgmyivwshldrl9a5p85f-libcxx-aarch64-apple-darwin-16.0.6-dev/include;/nix/store/jz398v8vw46y681ck0ssc54j5fv9lzvk-compiler-rt-libc-aarch64-apple-darwin-16.0.6-dev/include;/nix/store/67pf95zqmfvllb0bxiqnkdphscn5zxjq-libresolv-83-dev/include;/nix/store/304nrgnsfrw04rl7rjpf6f2519a25s80-libsbuf-14.1.0-dev/include;/nix/store/r7w9pr279j2fdk3k913rhck5qcb3rr52-cups-headers-2.4.11/include;/nix/store/8ng4rnckjpnvjgmyivwshldrl9a5p85f-libcxx-aarch64-apple-darwin-16.0.6-dev/include/c++/v1;/nix/store/ndwb5w7v2v5a32ysrr4d8i2m77f8r2x8-aarch64-apple-darwin-clang-wrapper-16.0.6/resource-root/include;/nix/store/bbwmxj5wv6nh3cydiyijp80zn30q5svf-apple-sdk-11.3/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include;/nix/store/9frdsg0prfc08ibfbzb41qgf8ispbwha-libSystem-B/include")
set(CMAKE_CXX_IMPLICIT_LINK_LIBRARIES "c++")
set(CMAKE_CXX_IMPLICIT_LINK_DIRECTORIES "/nix/store/md8l82d1ggi4136ja9qdpg855z6wavip-libcxx-16.0.6/lib;/nix/store/ahirzfv2ng038ia849dagnrmsjq7ssza-compiler-rt-libc-16.0.6/lib;/nix/store/rpx696jlwrapkd26mvim4msa77dr4shp-rust-default-1.83.0/lib;/nix/store/dka6i6yj8sgws93wc6m0lmqzhk21kq87-libiconv-107/lib;/nix/store/z0w80ykngrn8law3xl86ndnvr8dfngyy-mcfgthread-x86_64-w64-mingw32-1.6.1/lib;/nix/store/65y8rq0mlswvy6hd0rn1xbnfxsjzp94i-libcxx-x86_64-apple-darwin-16.0.6/lib;/nix/store/njsrfi3aj7k4zn4hnijq1i4l3wiclbp4-compiler-rt-libc-x86_64-apple-darwin-16.0.6/lib;/nix/store/0q8qyxn8n6v002y9ajcf91wdi8mmivc5-libcxx-aarch64-apple-darwin-16.0.6/lib;/nix/store/886af777ldsisya3i6148lrw4dxzzygv-compiler-rt-libc-aarch64-apple-darwin-16.0.6/lib;/nix/store/3w1yf8cl6djijxjx7qz79xlfc7j967fr-libresolv-83/lib;/nix/store/5z709fg1g533asl2mn5l3dpjn27m1k2w-libsbuf-14.1.0/lib;/nix/store/jipshwzjb9kjmvxifs7d4mx7z24bvp1d-libutil-72/lib;/nix/store/9frdsg0prfc08ibfbzb41qgf8ispbwha-libSystem-B/lib;/nix/store/5d3xypk63r66rqzrqfcwxlf2rj3l5gp6-clang-16.0.6-lib/aarch64-apple-darwin/lib;/nix/store/bbwmxj5wv6nh3cydiyijp80zn30q5svf-apple-sdk-11.3/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/lib")
set(CMAKE_CXX_IMPLICIT_LINK_FRAMEWORK_DIRECTORIES "/nix/store/bbwmxj5wv6nh3cydiyijp80zn30q5svf-apple-sdk-11.3/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/System/Library/Frameworks")
set(CMAKE_CXX_COMPILER_CLANG_RESOURCE_DIR "/nix/store/ndwb5w7v2v5a32ysrr4d8i2m77f8r2x8-aarch64-apple-darwin-clang-wrapper-16.0.6/resource-root")

set(CMAKE_CXX_COMPILER_IMPORT_STD "")
### Imported target for C++23 standard library
set(CMAKE_CXX23_COMPILER_IMPORT_STD_NOT_FOUND_MESSAGE "Unsupported generator: Unix Makefiles")



