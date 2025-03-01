#!/bin/sh
DIR_CLIENT="/client"
DIR_CLIENT_DATA="/output"

MAP_THREADS=${MAP_THREADS:-8}

if [ ! -d "$DIR_CLIENT" ]; then
  echo "Client not found in '$DIR_CLIENT', aborting extraction" >&2
  exit 1
fi

if [ ! -d "$DIR_CLIENT_DATA" ]; then
  echo "Client data directory does not exist in '$DIR_CLIENT_DATA', aborting extraction" >&2
  exit 1
fi

(
    cd "$DIR_CLIENT_DATA"

    dir_extractors="/opt/mangos/bin/Extractors"
    echo "MapExtractor"
    "$dir_extractors/MapExtractor" -i "$DIR_CLIENT"
    echo "VMapExtractor"
    "$dir_extractors/VMapExtractor" -d "$DIR_CLIENT/Data"
    echo "VMapAssembler"
    "$dir_extractors/VMapAssembler"
    echo "mmap_extract"
    python "$dir_extractors/mmap_extract.py" \
        --configInputPath "$dir_extractors/config.json" \
        --offMeshInput "$dir_extractors/offmesh.txt"

    # for i in 0 1 13 29 30 33 34 35 36 37 42 43 44 47 48 70 90 109 129 169 189 209 229 230 249 269 289 309 329 349 369 389 409 429 449 450 451 469 489 509 529 531 533
    # do
    #   "$dir_extractors/MoveMapGenerator" \
    #     --silent \
    #     --threads "$MAP_THREADS" \
    #     --configInputPath "$dir_extractors/config.json" \
    #     --offMeshInput "$dir_extractors/offmesh.txt" \
    #     $i
    # done
  
    rm -rf ./Buildings ./Cameras
)
