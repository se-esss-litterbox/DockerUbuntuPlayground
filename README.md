# DockerUbuntuPlayground
A containerised EPICS environment

EPICS can be somewhat awkward to install, especially for new users.  This container provides the
user with an Ubuntu terminal, and a full installation of EPICS -- including ASyn Driver and StreamDevice.

This container can be used (from a machine with docker already installed) with the following command:

docker run -i -t --rm sdmolloy/ubuntu-playground:latest /bin/bash

Further instructions/guidance will appear on http://www.smolloy.com/blog in due course.
