import tensorflow as tf
import cv2
import torch
import numpy as np
import lpips
from tqdm import tqdm
import matplotlib.pyplot as plt
from itertools import product
from image_similarity_measures import quality_metrics

def imageMetrics(origin, comp):
    psnr = quality_metrics.psnr(origin, comp, max_p=255)
    ssim = quality_metrics.ssim(origin, comp, max_p=255)
    fsim = quality_metrics.fsim(origin, comp)
    origin = torch.from_numpy(cv2.cvtColor(origin, cv2.COLOR_BGR2RGB)).type(torch.float32).permute(2, 0, 1)/256
    comp = torch.from_numpy(cv2.cvtColor(comp, cv2.COLOR_BGR2RGB)).type(torch.float32).permute(2, 0, 1)/256
    loss_fn_alex = lpips.LPIPS(net='alex', verbose=False)
    lpip = loss_fn_alex(origin, comp).detach().numpy()[0][0][0][0].item()
    return psnr, ssim, fsim, lpip
    

def getScores(original_dir, compressed_dir, image_size=(288, 352)):
    original_video = np.fromfile(original_dir, dtype='uint8')
    compressed_video = cv2.VideoCapture(compressed_dir)
    H, W = image_size
    frame_size = H*W*3//2
    num_frames = 10*30
    scores = []
    for i in tqdm(range(num_frames)):
        original = original_video[i*frame_size:(i+1)*frame_size]
        original_yuv = original.reshape([H*3//2, W])
        original_bgr = cv2.cvtColor(original_yuv, cv2.COLOR_YUV2BGR_I420)
        _, compressed_bgr = compressed_video.read()
        scores.append(imageMetrics(original_bgr, compressed_bgr))
    compressed_video.release()
    return np.mean(scores, axis=0)
    
    
if __name__ == '__main__':
    score_names = ['PSNR', 'SSIM', 'FSIM', 'LPIPS']
    vids = list(product(['foreman', 'mobile'], ['nofilter', 'deblock']))
    scores = []
    QPs = [22, 30, 38, 46]
    for vid in vids:
        origin_dir = f'{vid[0]}_cif.yuv'
        score = []
        for QP in QPs:
            comp_dir = f'result/{vid[0]}_Q{QP}_{vid[1]}.mp4'
            print(comp_dir)
            scores.append(getScores(origin_dir, comp_dir))
    scores = np.reshape(scores, [4, 4, 4]).transpose([2, 0, 1])
    np.save('scores.npy', scores)
    for i, score_name in enumerate(score_names):
        plot_marker = iter(['-*', '-o', '-s', '-d'])
        for j, vid in enumerate(vids):
            plt.plot(QPs, scores[i][j], next(plot_marker), label=f'{vid[0]} {vid[1]}')
            
        plt.title(f'{score_name} Score in various videos and filters')
        plt.xlabel('Quantization Parameters')
        plt.ylabel(f'{score_name}')
        plt.legend()
        plt.savefig(f'{score_name}.png')
        plt.clf()
    
    