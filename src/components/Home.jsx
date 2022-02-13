import React, {useState} from "react";
import Moralis from "moralis";
import ImgCrop from 'antd-img-crop';
import { Card, Typography, Button, Input, Upload } from "antd";
import { useMoralis, useWeb3Contract } from "react-moralis";
import { abi } from "../contracts/Mintango.json";
import { useIPFS } from "../hooks/useIPFS";

const { TextArea } = Input;

export default function Minter() {

  const [name, setName] = useState("");
  const [description, setDescription] = useState("");
  const [file, setFile] = useState(null);

  const { account } = useMoralis();
  const { resolveLink, isUploading, error, moralisFile, mintNft } = useIPFS();
  // const { runContractFunction, isLoading } = useWeb3Contract(
  // });

  const onFileChange = ({ file: newFile }) => {
    setFile(newFile);
  };

  const onPreview = async file => {
    let src = file.url;
    if (!src) {
      src = await new Promise(resolve => {
        const reader = new FileReader();
        reader.readAsDataURL(file.originFileObj);
        reader.onload = () => resolve(reader.result);
      });
    }
    const image = new Image();
    image.src = src;
    const imgWindow = window.open(src);
    imgWindow.document.write(image.outerHTML);
  };

  const mintAndGo = async () => {
    const cid = await mintNft(name, description, file);
    console.log("CID", cid)
    const minter = await Moralis.executeFunction({
      functionName: "mint",
      abi,
      contractAddress: "0x7247d02546EA6d0f1A46403081f1874463fBE08a",
      params: {
        cid,
        data: []
      }
    })
    console.log("Minter", minter)
  }

  return (
    <div style={{ display: "flex" }}>
      <Card
        bordered={false}
        style={{
          width: 500,
          display: "flex",
          flexDirection: "column",
          alignItems: "center",
          textAlign: "center",
          zIndex: 1,
        }}
      >
        <Typography.Title level={3}>NFT Minter</Typography.Title>
        <Input showCount placeholder="Name" maxLength={20} onChange={e => setName(e.target.value)} style={{ marginBottom: "1rem" }}/>
        <TextArea showCount placeholder="Description..." maxLength={140} onChange={e => setDescription(e.target.value)} style={{ marginBottom: "1rem"}}/>
        <div style={{ marginBottom: "1rem"}}>
          <Upload
              accept="image/*"
              listType="picture-card"
              onChange={onFileChange}
              onPreview={onPreview}
              onRemove={() => {setFile(null)}}
              beforeUpload={() => {return false}}
            >
              {!file && '+ Upload'}
            </Upload>
            
        </div>
        <Button
          type="primary"
          shape="round"
          size="large"
          style={{ width: "100%" }}
          // loading={isLoading}
          onClick={() => mintAndGo()}
        >
          MINT ANG GO
        </Button>
      </Card>
    </div>
  );
}
