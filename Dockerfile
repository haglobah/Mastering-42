FROM racket/racket:8.8-full

RUN raco pkg install --auto pollen
RUN mkdir app

CMD ["raco", "pollen", "start", "/app"]

EXPOSE 8080