# get baseimage
FROM ubuntu:latest

RUN apt-get update -y
RUN apt-get upgrade -y
# reinstall certificates, otherwise git clone command might result in an error
RUN apt-get install --reinstall ca-certificates -y

# install developer dependencies
RUN apt-get install -y git build-essential make --no-install-recommends

# install vcpkg package manager
RUN git clone https://github.com/microsoft/vcpkg
RUN apt-get install -y curl zip
RUN vcpkg/bootstrap-vcpkg.sh

# install crow package
RUN /vcpkg/vcpkg install crow

# copy files from local directory to container
COPY . .

# define working directory from container
WORKDIR /

# Set the vcpkg toolchain file
ENV VCPKG_ROOT=/vcpkg
ENV VCPKG_DEFAULT_TRIPLET=x64-linux
ENV CMAKE_TOOLCHAIN_FILE=/vcpkg/scripts/buildsystems/vcpkg.cmake

# compile with CMake 
RUN bash -c "make"

# run executable (name has to match with CMakeLists.txt file)
CMD [ "./backend.out" ]