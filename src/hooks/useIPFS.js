import { useMoralisFile } from "react-moralis";


export const useIPFS = () => {

  const {
    error,
    isUploading,
    moralisFile,
    saveFile,
  } = useMoralisFile();

  // Format the IPFS url
  const resolveLink = (url) => {
    if (!url || !url.includes("ipfs://")) return url;
    return url.replace("ipfs://", "https://gateway.ipfs.io/ipfs/");
  };

  // Upload image to IPFS
  const uploadImage = async (image) => {
    const file = await saveFile(image.name, image, { saveIPFS: true })
    console.log(file);
    return file;
    // console.log(file.ipfs(), file.hash())
    // return file.ipfs()
  };

  // Upload metadata to IPFS
  const uploadMetadata = async (name, description, imageURL) => {
    const metadata = {
        "name": name,
        "description": description,
        "image": imageURL
      }
    const file = await saveFile("file.json", {base64 : Buffer.from(JSON.stringify(metadata), 'base64')});
    console.log(file.ipfs())
    return file;
};

  // Mint NFT
  const mintNft = async () => {
      const image = await uploadImage();
      await uploadMetadata(image);
  };

  return { resolveLink, isUploading, error, moralisFile, mintNft };
};
