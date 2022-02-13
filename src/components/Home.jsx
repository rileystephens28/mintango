import React, {useState} from "react";
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
  const { runContractFunction, isLoading } = useWeb3Contract({
    functionName: "mint",
    abi,
    contractAddress: "0xc44a27657627A89D522F98c04C9Fa820484Af46A",
    params: {
      account,
      id: 0,
      amount: 1,
    },
  });

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

  return (
    <div style={{ display: "flex" }}>
      <Card
        bordered={false}
        style={{
          width: 600,
          display: "flex",
          flexDirection: "column",
          alignItems: "center",
          textAlign: "center",
        }}
      >
        <Typography.Title level={3}>NFT Minter</Typography.Title>
        <Input showCount placeholder="Name" maxLength={20} onChange={setName} style={{ marginBottom: "1rem" }}/>
        <TextArea showCount placeholder="Description..." maxLength={140} onChange={setDescription} style={{ marginBottom: "1rem"}}/>
        <div style={{ marginBottom: "1rem"}}>
            <Upload
              accept="image/*"
              listType="picture-card"
              file={file}
              onChange={onFileChange}
              onPreview={onPreview}
              onRemove={() => setFile(null)}
            >
              {!file && '+ Upload'}
            </Upload>
        </div>
        <Button
          type="primary"
          shape="round"
          size="large"
          style={{ width: "100%" }}
          loading={isLoading}
          onClick={() => runContractFunction()}
        >
          MINT ANG GO
        </Button>
      </Card>
    </div>
  );
}
