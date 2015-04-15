clear all
videoFReader = vision.VideoFileReader('D:\study\MTech_2nd_sem\Face_Detection\matlab code\Video6.mp4');
i=0;
while ~isDone(videoFReader)
    i=i+1;
  videoFrame = step(videoFReader);
  imwrite(videoFrame,strcat('D:\study\MTech_2nd_sem\Face_Detection\frame_images\',num2str(i),'.jpg'));
end


  