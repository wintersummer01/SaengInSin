rm result/*

./ffmpeg -video_size cif -framerate 30 -i foreman_cif.yuv -vcodec libx264 -qp 22 -deblock -6:-6 result/foreman_Q22_nofilter.mp4
./ffmpeg -video_size cif -framerate 30 -i foreman_cif.yuv -vcodec libx264 -qp 30 -deblock -6:-6 result/foreman_Q30_nofilter.mp4
./ffmpeg -video_size cif -framerate 30 -i foreman_cif.yuv -vcodec libx264 -qp 38 -deblock -6:-6 result/foreman_Q38_nofilter.mp4
./ffmpeg -video_size cif -framerate 30 -i foreman_cif.yuv -vcodec libx264 -qp 46 -deblock -6:-6 result/foreman_Q46_nofilter.mp4

./ffmpeg -video_size cif -framerate 30 -i foreman_cif.yuv -vcodec libx264 -qp 22 -deblock 6:6 result/foreman_Q22_deblock.mp4
./ffmpeg -video_size cif -framerate 30 -i foreman_cif.yuv -vcodec libx264 -qp 30 -deblock 6:6 result/foreman_Q30_deblock.mp4
./ffmpeg -video_size cif -framerate 30 -i foreman_cif.yuv -vcodec libx264 -qp 38 -deblock 6:6 result/foreman_Q38_deblock.mp4
./ffmpeg -video_size cif -framerate 30 -i foreman_cif.yuv -vcodec libx264 -qp 46 -deblock 6:6 result/foreman_Q46_deblock.mp4

./ffmpeg -video_size cif -framerate 30 -i mobile_cif.yuv -vcodec libx264 -qp 22 -deblock -6:-6 result/mobile_Q22_nofilter.mp4
./ffmpeg -video_size cif -framerate 30 -i mobile_cif.yuv -vcodec libx264 -qp 30 -deblock -6:-6 result/mobile_Q30_nofilter.mp4
./ffmpeg -video_size cif -framerate 30 -i mobile_cif.yuv -vcodec libx264 -qp 38 -deblock -6:-6 result/mobile_Q38_nofilter.mp4
./ffmpeg -video_size cif -framerate 30 -i mobile_cif.yuv -vcodec libx264 -qp 46 -deblock -6:-6 result/mobile_Q46_nofilter.mp4

./ffmpeg -video_size cif -framerate 30 -i mobile_cif.yuv -vcodec libx264 -qp 22 -deblock 6:6 result/mobile_Q22_deblock.mp4
./ffmpeg -video_size cif -framerate 30 -i mobile_cif.yuv -vcodec libx264 -qp 30 -deblock 6:6 result/mobile_Q30_deblock.mp4
./ffmpeg -video_size cif -framerate 30 -i mobile_cif.yuv -vcodec libx264 -qp 38 -deblock 6:6 result/mobile_Q38_deblock.mp4
./ffmpeg -video_size cif -framerate 30 -i mobile_cif.yuv -vcodec libx264 -qp 46 -deblock 6:6 result/mobile_Q46_deblock.mp4