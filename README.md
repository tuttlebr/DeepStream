# DeepStream
DeepStream SDK delivers a complete streaming analytics toolkit for real-time AI based video and image understanding and multi-sensor processing. This repo is for NVIDIA Jetson platform (Linux for Tegra) or NVIDIA Amphere GPUs (Linux).

## Lanching the Notebook
* For both amd64 and arm64 services, you need to enable access to the display of the machine. If you're only able to access remotely, you will only be able to run inference on a video and play it in the notebook, not stream to the display/xhost.

```bash
brandon@olympus:~/DeepStream$ xhost +
```
### NVIDIA Amphere GPU
```bash
brandon@olympus:~/DeepStream$ docker-compose up --build deepstream
```
### NVIDIA Jetson Devices (L4T)
```bash
brandon@olympus:~/DeepStream$ docker-compose up --build deepstream-l4t
```
## Running the samples

1. Open the Jupyter Lab in your browser and run some examples!
   ```bash
   deepstream-app -c <path to config.txt>
   ```
   Some examples require a USB camera, xhost access, or even GPU count > 1. 
2. Application config files included in `configs/deepstream-app/`
   a. source30_1080p_dec_infer-resnet_tiled_display_int8.txt (30 Decode + Infer)
   b. source4_1080p_dec_infer-resnet_tracker_sgie_tiled_display_int8.txt
      (4 Decode + Infer + SGIE + Tracker)
   c. source4_1080p_dec_infer-resnet_tracker_sgie_tiled_display_int8_gpu1.txt
      (4 Decode + Infer + SGIE + Tracker executed on gpu1)
3. Configuration files for "nvinfer" element in `configs/deepstream-app/`
   a. config_infer_primary.txt (Primary Object Detector)
   b. config_infer_secondary_carcolor.txt (Secondary Car Color Classifier)
   c. config_infer_secondary_carmake.txt (Secondary Car Make Classifier)
   d. config_infer_secondary_vehicletypes.txt (Secondary Vehicle Type Classifier)


## Running the Triton Inference Server samples


Instructions to prepare and run Triton inference server samples
are provided in samples/configs/deepstream-app-triton/README.


Downloading and Running the Pre-trained Transfer Learning Toolkit Models

Instructions to download and run the pre-trained Transfer Learning Toolkit models
are provided in samples/configs/tao_pretrained_models/README.


### Notes:

1. If the application runs into errors, cannot create gst elements, try again
after removing gstreamer cache
   rm ${HOME}/.cache/gstreamer-1.0/registry.x86_64.bin
2. When running deepstream for first time, the following warning might show up:
   "GStreamer-WARNING: Failed to load plugin '...libnvdsgst_inferserver.so':
    libtrtserver.so: cannot open shared object file: No such file or directory"
This is a harmless warning indicating that the DeepStream's nvinferserver plugin
cannot be used since "Triton Inference Server" is not installed.
If required, try DeepStream's TRT-IS docker image or install the Triton Inference
Server manually. For more details, refer to https://github.com/NVIDIA/triton-inference-server.