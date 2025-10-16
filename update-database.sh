#!/bin/bash

FILES=(
	"GeoLite2-Country.mmdb"
	"GeoLite2-City.mmdb"
	"GeoLite2-ASN.mmdb"
)

WORK_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

SOURCE_DIR=/usr/share/GeoIP
TARGET_DIR=${WORK_DIR}/database

cd "${WORK_DIR}"

git pull origin main

for file in "${FILES[@]}"; do
	source_file="${SOURCE_DIR}/${file}"
	target_file="${TARGET_DIR}/${file}"

	if [ ! -f "${source_file}" ]; then
		echo "Source file ${source_file} does not exist. Skipping."
		continue
	fi

	if [ -f "${target_file}" ]; then
		source_file_md5=$(md5sum "${source_file}" | cut -c -32)
		target_file_md5=$(md5sum "${target_file}" | cut -c -32)

		if [ "${source_file_md5}" == "${target_file_md5}" ]; then
			echo "File ${file} is up to date. Skipping."
			continue
		fi
	fi

	cp "${source_file}" "${target_file}"
	echo "Updated ${file}."
done

git add .
git commit -m "Update GeoIP databases"
git push origin main

echo "Database update process completed."
