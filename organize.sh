#!/bin/bash

# Base directory
BASE_DIR="$HOME/linuxproject"

# Creates base directory if not exists
mkdir -p "$BASE_DIR"

# Folders inside linuxproject
FOLDERS=("Images" "Videos" "Music" "Documents" "Archives" "Executables" "Scripts" "Programming" "Fonts" "Others")

# Creates subfolders
for folder in "${FOLDERS[@]}"; do
    mkdir -p "$BASE_DIR/$folder"
done

# Log file
LOG_FILE="$BASE_DIR/organizer.log"
echo "===== Run at $(date) =====" >> "$LOG_FILE"

# Chooses directory to scan (Downloads)
SOURCE_DIR="$HOME/Downloads"

# Loops through files
for file in "$SOURCE_DIR"/*; do

    # Skips if no files
    [ -e "$file" ] || continue

    # Gets filename and extension
    filename="$(basename "$file")"
    ext="${filename##*.}"
    ext=$(echo "$ext" | tr '[:upper:]' '[:lower:]')  # lowercase

    case "$ext" in
        # Images
        jpg|jpeg|png|gif|bmp|tiff|svg|webp|ico)
            target="Images"
            ;;

        # Videos
        mp4|mkv|mov|avi|flv|wmv|webm|mpeg|mpg|m4v)
            target="Videos"
            ;;

        # Audio
        mp3|wav|flac|aac|ogg|m4a|wma)
            target="Music"
            ;;

        # Documents
        pdf|doc|docx|xls|xlsx|ppt|pptx|txt|rtf|odt|ods|odp|csv)
            target="Documents"
            ;;

        # Archives
        zip|rar|7z|tar|gz|bz2|xz|iso)
            target="Archives"
            ;;

        # Executables
        exe|bin|dll|deb|rpm|appimage)
            target="Executables"
            ;;

        # Shell/Automation scripts
        sh|bash|zsh)
            target="Scripts"
            ;;

        # Programming files
        py|js|ts|html|css|php|java|c|cpp|cs|go|rs|kt|dart|rb|swift|xml|json|yaml|yml)
            target="Programming"
            ;;

        # Fonts
        ttf|otf|woff|woff2)
            target="Fonts"
            ;;

        # Everything else
        *)
            target="Others"
            ;;
    esac

    # Moves file
    mv "$file" "$BASE_DIR/$target/"

    # Log the move
    echo "$(date): Moved '$filename' → $target/" >> "$LOG_FILE"

done

echo "Done! All files organized into $BASE_DIR"
