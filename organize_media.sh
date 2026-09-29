#!/bin/bash

# Source and destination directories
SRC="/srv/mitorrents"
FILM_DEST="/srv/media/videos"
MUSIC_DEST="/srv/media/music"

# Prompt user for the file extension
read -p "Enter the file extension to process (e.g., mkv, mp4, mp3): " ext

# Validate that an extension was entered
if [ -z "$ext" ]; then
    echo "No extension provided. Exiting."
    exit 1
fi

# Ask whether it's film or music
echo "Select destination category for *.$ext files:"
echo "1) Film ($FILM_DEST)"
echo "2) Music ($MUSIC_DEST)"
read -p "Enter choice [1-2]: " choice

case $choice in
    1)
        DEST="$FILM_DEST"
        ;;
    2)
        DEST="$MUSIC_DEST"
        ;;
    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac

# Find and process files matching the extension
find "$SRC" -type f -name "*.$ext" | while read -r file; do
    echo "Moving: "$file" -> $DEST"
    mv "$file" "$DEST/"
    
    # Extract the filename to apply permissions in the destination
    filename=$(basename "$file")
    
    echo "Setting permissions for: $filename"
    chown root:mediawriters "$DEST/$filename"
    chmod 2775 "$DEST/$filename"
done

echo "Processing complete!"
