# DockerUbuntuPlayground
A containerised EPICS environment

EPICS can be somewhat awkward to install, especially for new users.  This container provides the
user with an Ubuntu terminal, with a "pi" user (due to the fact that this evolved from an installation
on a Raspberry Pi), and a full installation of EPICS -- including ASyn Driver and StreamDevice.

This container can be used (from a machine with docker already installed) with the following command:
	docker run -i -t sdmolloy/ubuntu-playground:latest /bin/bash

Further instructions/guidance will appear on http://www.smolloy.com/blog in due course.
