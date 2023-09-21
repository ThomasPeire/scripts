# ============================
# Clone all repos in repos.txt
# ============================

while read repo; do
git clone "$repo"
sleep 1
done < repos.txt
read -p "Press enter to exit"
