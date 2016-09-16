# Set the base image to Torch (ubuntu 14.04)
FROM kaixhin/torch:latest

# Install Waffle http server for REST
RUN luarocks install async && \
    luarocks install s3 && \
    luarocks install ftcsv && \
    luarocks install https://raw.githubusercontent.com/benglard/htmlua/master/htmlua-scm-1.rockspec && \
    luarocks install https://raw.githubusercontent.com/benglard/waffle/master/waffle-scm-1.rockspec

RUN mkdir src
ADD app.lua ./src

WORKDIR ./src

CMD [ "th", "app.lua" ]
