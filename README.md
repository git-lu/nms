# NMS (Non-Maximum Suppression) for Object Detection in Python

Implementation of the Non-Maximum Supression Algorithm in python.

## Usage
### Docker

- build the image ```sudo docker build --tag ml-challenge . ```
- run the image to execute a demo ```sudo docker run ml-challenge```

The demo will save the original given bounding boxes and the output of the model in the /images folder.


### Conda enviroment
- Install anaconda
https://docs.conda.io/projects/conda/en/latest/user-guide/install/
- Create environment from yml file:
```conda env create -f ml-challenge.yml```


To use this implementation you should add the nms package to your proyect folders and
import it.

## Improving NMS with NMS-soft

To fully understand the improvements of NMS-soft over NMS, first it is important
to understand how NMS works.  

Suppose you have an image detection pipeline. Tipically, you will have a component
to generate proposals for classification which are candidate regions for the object of interest.
NMS is a technique to filter the candidate proposals, obtaining a final set of detections significantly reducing the number of false-positives.  


The algorithm to findind the best candidate is pretty intuitive. Given a set of candidates $B$ and a set of confidence scores for each of those candidates $S$, we choose the candidate with the biggest score AND, to achieve a "clean" solution, we remove (actually we drop the score to 0)
any other candidate that is within an "overlap threshold" previously set by us. This means that we only keep the best possible fit for each image.  

One of the issues arises when we have overlapped images: What happens if there is another object, which I want to detect, within the overlap threshold? Well, it depends on the overlap threshold. This could lead to major reduction in the model accuracy because we could be "eliminating" a good candidate for the other object. If the model had trouble identifying the overlapped object, or it identified a good candidate that is really close to our overlap threshold, we could be eliminating the best candidate. Of course a possible solution is trying to find the minimal threshold, but that might not be possible.

With NMS-Soft, instead of dropping the score of overlapping candidates to zero, we decrease the
overlapped candidate score as an increasing function of overlap. Which is very reasonable.
If we have a candidate that is really close to the threshold (meaning it is very close to not being eliminated), it can keep it's original score and still be a candidate to pick for any other object. But if the candidate is very over the overlapping threshold it score will be lowered in consequeance.
Thus we get rid of the threshold problem (or we minimize it's consequences) without adding any computational cost or re-training cost to our algorithm.

