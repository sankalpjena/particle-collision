rm -r ./plots/*.png
python3 postproc/animation.py
#ffmpeg -r 20 -i plots/image%d.png -pix_fmt yuv420p ./animations/bb.mp4