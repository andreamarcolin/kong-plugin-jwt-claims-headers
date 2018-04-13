FROM kong
COPY *.lua /usr/local/share/lua/5.1/kong/plugins/jwt-claims-headers/
COPY kong-plugin-jwt-claims-headers-1.0-1.rockspec /usr/local/lib/luarocks/rocks/kong/${KONG_VERSION}-0/