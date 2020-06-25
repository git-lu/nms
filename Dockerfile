FROM continuumio/miniconda3

# Create the environment:
COPY nms/ nms/
COPY images/ images/
COPY nms_run.py .

RUN conda create --name ml-challenge python=3.7
RUN conda install -n ml-challenge -c anaconda numpy
RUN conda install -n ml-challenge -c conda-forge opencv

# The code to run when container is started:
ENTRYPOINT ["conda", "run", "-n", "ml-challenge", "python", "nms_run.py"]

