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
  const uploadImage = async (imageFile) => {
    const file = await saveFile(imageFile.name, imageFile, { saveIPFS: true })
    return file.ipfs();
  };

  // Upload metadata to IPFS
  const uploadMetadata = async (name, description, imageURL) => {
    const metadata = {
        "name": name,
        "description": description,
        "image": imageURL
      }
      
    // const file = await saveFile("file.json", {saveIPFS: true, base64 : Buffer.from(JSON.stringify(metadata), 'base64')});
    // const buff = Buffer.from(JSON.stringify(metadata), 'base64')
    const buff = btoa(JSON.stringify(metadata))
    const file = await saveFile("0x00.json", {base64: buff}, {saveIPFS: true});
    return file.hash();
};

  // Mint NFT
  const mintNft = async (name, description, imageFile) => {
      const image = await uploadImage(imageFile);
      const cidHash = await uploadMetadata(name, description, image);
      return cidHash;
  };

  return { resolveLink, isUploading, error, moralisFile, mintNft };
};
