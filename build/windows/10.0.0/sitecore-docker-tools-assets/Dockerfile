# escape=`

ARG BASE_IMAGE
ARG TOOL_IMAGE

FROM ${TOOL_IMAGE} as tools
FROM ${BASE_IMAGE}

COPY --from=tools tools/ tools/
