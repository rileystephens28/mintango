import React, { useState } from "react";
import { Modal, Button } from 'antd';

const MintConfirmModal = ({ visible, onDismiss}) => {

    return (
      <>
        <Modal
          title="Thanks for minting with us!"
          centered
          visible={visible}
          onOk={() => onDismiss()}
          onCancel={() => onDismiss()}
          cancelButtonProps={{ style: { display: 'none' } }}
        >
          <p>It may take a couple minutes for your new NFT to be confirmed. Your freshly minted NFT will appear under the "My Goods" tabs.</p>
        </Modal>
      </>
    );
} 

export default MintConfirmModal;