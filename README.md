## straton® soft PLC

Made for [netPI](https://www.netiot.com/netpi/), the Open Edge Connectivity Ecosystem

### Debian with straton soft PLC runtime from group COPA-DATA

The image provided hereunder deploys a container with installed Debian and the soft PLC [straton](https://www.straton-plc.com/) for Raspberry PI (unlicensed).

Base of this image builds a tagged version of [debian:jessie](https://hub.docker.com/r/resin/armv7hf-debian/tags/) with unlicensed straton [runtime for Raspberry PI](https://www.straton-plc.com/en/news/success-stories/raspberry/) T5 in the version 9.1 which runs 15 minutes until it turns into a demo mode.

To upgrade to a full featured version use the image's building script as a template, add your bought `K5License.ini` (MAC address bound) file from COPA-DATA to the runtime folder `/home/pi`, rebuild it in an own repository and then deploy it on netPI.

#### Container prerequisites

##### Port mapping

To allow the access to the runtime from the straton IDE tool suite the container TCP port `1100` needs to be exposed to the host.

##### Privileged mode

The straton runtime need access on system level. Only the enabled privileged mode option lifts the enforced container limitations to allow the runtime system level access.

#### Getting started

STEP 1. Open netPI's landing page under `https://<netpi's ip address>`.

STEP 2. Click the Docker tile to open the [Portainer.io](http://portainer.io/) Docker management user interface.

STEP 3. Enter the following parameters under **Containers > Add Container**

* **Image**: `hilschernetpi/netpi-straton-softplc`

* **Port mapping**: `Host "1100" -> Container "1100"` 

* **Restart policy"** : `always`

* **Runtime > Privileged mode** : `On`

STEP 4. Press the button **Actions > Start container**

Pulling the image from Docker Hub may take up to 5 minutes.

#### Accessing

The container starts the straton runtime automatically. It is immediately ready to receive commands through the straton IDE tool suite. You have 15 minutes time for evaluation until the runtime turns into demo mode. You have to restart the container to reset the timer.

Use the straton IDE and create a new project as usual. Select `T5 Runtime` as runtime and netpi's ip address as ip address. After the default project has been created establish a connection to the runtime on netPI using the menu item `Project/online` and continue to use straton IDE as usual.

#### Tags

* **hilscher/netPI-straton-softplc:latest** - non-versioned latest development output of the master branch. Can run on any netPI system software version.

#### GitHub sources
The image is built from the GitHub project [netPI-straton-softplc](https://github.com/Hilscher/netPI-straton-softplc). It complies with the [Dockerfile](https://docs.docker.com/engine/reference/builder/) method to build a Docker image [automated](https://docs.docker.com/docker-hub/builds/).

To build the container for an ARM CPU on [Docker Hub](https://hub.docker.com/)(x86 based) the Dockerfile uses the method described here [resin.io](https://resin.io/blog/building-arm-containers-on-any-x86-machine-even-dockerhub/).

[![N|Solid](http://www.hilscher.com/fileadmin/templates/doctima_2013/resources/Images/logo_hilscher.png)](http://www.hilscher.com)  Hilscher Gesellschaft fuer Systemautomation mbH  www.hilscher.com
