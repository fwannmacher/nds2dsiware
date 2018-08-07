root_folder=$(basename "${1}" ".nds")
title_id=$(python print_rom_data.py "${1}" title_id)
save_size=$(python print_rom_data.py "${1}" save_size)
content_folder="${root_folder}/${title_id}/content"
data_folder="${root_folder}/${title_id}/data"
fat_size=save_size

mkdir -p "${content_folder}"
mkdir "${data_folder}"
./maketmd "${1}"
mv title.tmd "${content_folder}/."

if [[ fat_size -lt 65536 ]]
then
    fat_size=65536
fi

dd if=/dev/zero of=public.sav bs=1 count=$fat_size
mkfs.msdos -v -F 12 public.sav
truncate -s ${save_size} public.sav
mv public.sav "${data_folder}/."
cp "${1}" "${content_folder}/00000000.app"
