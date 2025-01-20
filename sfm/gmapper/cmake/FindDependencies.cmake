################################################################################
# Find packages
################################################################################
find_package(Eigen3 3.4 REQUIRED)
find_package(Glog REQUIRED)
if(DEFINED glog_VERSION_MAJOR)
  # Older versions of glog don't export version variables.
  add_definitions("-DGLOG_VERSION_MAJOR=${glog_VERSION_MAJOR}")
  add_definitions("-DGLOG_VERSION_MINOR=${glog_VERSION_MINOR}")
endif()

# Ceres
find_package(Ceres REQUIRED)
if(${CERES_VERSION} VERSION_LESS "2.2.0")
    # ceres 2.2.0 changes the interface of local parameterization
    add_definitions("-DCERES_PARAMETERIZATION_ENABLED")
endif()

# SuiteSparse
find_package(CUDA REQUIRED)
include_directories(${CUDA_INCLUDE_DIRS})
find_package(SuiteSparse REQUIRED COMPONENTS CHOLMOD CHOLMOD_CUDA)
include_directories(${SUITESPARSE_INCLUDE_DIRS})

# OpenMP
if(OPENMP_ENABLED)
  find_package(OpenMP)
  if(OPENMP_FOUND)
    message(STATUS "Enabling OpenMP support")
    add_definitions("-DOPENMP_ENABLED")
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${OpenMP_C_FLAGS}")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${OpenMP_CXX_FLAGS}")
  endif()
endif()

# Theia
include(FetchContent)
FetchContent_Declare(Theia
    GIT_REPOSITORY    https://github.com/B1ueber2y/TheiaSfM.git
    GIT_TAG           d522fdc7aa215acd04cbdadfa9cdc9bf98e14144
    EXCLUDE_FROM_ALL
)
message(STATUS "Configuring Theia...")
if (FETCH_THEIA) 
    FetchContent_MakeAvailable(Theia)
else()
    find_package(Theia REQUIRED)
endif()
message(STATUS "Configuring Theia... done")

# COLMAP
FetchContent_Declare(COLMAP
    GIT_REPOSITORY    https://github.com/B1ueber2y/colmap.git
    GIT_TAG           dc3105808991fa0a0c4f6167a5edfcb92735b14b
    EXCLUDE_FROM_ALL
)
message(STATUS "Configuring COLMAP...")
if (FETCH_COLMAP) 
    FetchContent_MakeAvailable(COLMAP)
else()
    find_package(COLMAP REQUIRED)
endif()
message(STATUS "Configuring COLMAP... done")

