BUILDS_DIR="builds"
TORRENTS_DIR="torrents"

TRACKERS=(
  "udp://tracker.openbittorrent.com:80/announce"
  "udp://tracker.opentrackr.org:1337/announce"
)

mkdir -p "$TORRENTS_DIR"

for dir in "$BUILDS_DIR"/*; do
    [ -d "$dir" ] || continue

    folder_name=$(basename "$dir")
    torrent_file="$TORRENTS_DIR/${folder_name}.torrent"

    echo "Creating torrent for $folder_name..."

    # Build tracker arguments
    tracker_args=()
    for tracker in "${TRACKERS[@]}"; do
    	tracker_args+=(-u "$tracker")
    done

    mktorrent \
  -a udp://tracker.openbittorrent.com:80/announce \
  -a udp://tracker.opentrackr.org:1337/announce \
  -o "$torrent_file" \
  "$dir"

    echo "Saved: $torrent_file"
done

echo "All torrents created."
