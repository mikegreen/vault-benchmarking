-- from 
-- https://github.com/jdfriedma/Vault-Transit-Load-Testing/blob/master/postbatch320.lua
-- example HTTP POST script which demonstrates setting the
-- HTTP method, body, and adding a header
-- example usage:
-- wrk -t1 -c1 -d10s -H "X-Vault-Token: $VAULT_TOKEN" -s transit_post320.lua $VAULT_ADDR/v1/transitTest/encrypt/test  -- 50000


wrk.method = "POST"
-- wrk.body   = '{"batch_input": [{"plaintext" : "dGVldkV0R2ZodVV5Yk9zUA=="}, {"plaintext" : "SUVyeEdWUUF5U0pSY3hwTw=="}, {"plaintext" : "TXJjZkhsUnpWZkpOeWRhRQ=="}, {"plaintext" : "YWJnS013R3p2aWpCek1HUw=="}, {"plaintext" : "bHNIQXpOQWttd1RPUEdjbw=="}, {"plaintext" : "b0FDV1hlYmJJUUN4RUFQag=="}, {"plaintext" : "dVhQcEx0T0l1WFpvZm1xTg=="}, {"plaintext" : "Qk91ZGt4a2VLbnBLaUdMQQ=="}, {"plaintext" : "ZUJlRGJQb0ZDYkhzcFd1dA=="}, {"plaintext" : "a3FWelJqSFhYZ1R5ekNUeA=="}, {"plaintext" : "R3J0VGpVSHpseXBobWpJSA=="}, {"plaintext" : "bXNFaFRZdUR0ZXdWb0J6RA=="}, {"plaintext" : "U0tXTFZ3a1lDV2dIV29RSA=="}, {"plaintext" : "UmdYUmZnSHJSRUdOZGtIWQ=="}, {"plaintext" : "dFpER1loRHlGT0VoSUJVUw=="}, {"plaintext" : "WGJnVGxla0VUTUhiTFlKUg=="}, {"plaintext" : "aXRNcWpUaGNnTGNST3ZBeQ=="}, {"plaintext" : "R2llWGNteU5NT3JWWG5WRQ=="}, {"plaintext" : "cEFVcVZlcHFQQ05ic0hhdA=="}, {"plaintext" : "eXVWeHdUQ25RQXJCemxNRA=="},{"plaintext" : "dGVldkV0R2ZodVV5Yk9zUA=="}, {"plaintext" : "SUVyeEdWUUF5U0pSY3hwTw=="}, {"plaintext" : "TXJjZkhsUnpWZkpOeWRhRQ=="}, {"plaintext" : "YWJnS013R3p2aWpCek1HUw=="}, {"plaintext" : "bHNIQXpOQWttd1RPUEdjbw=="}, {"plaintext" : "b0FDV1hlYmJJUUN4RUFQag=="}, {"plaintext" : "dVhQcEx0T0l1WFpvZm1xTg=="}, {"plaintext" : "Qk91ZGt4a2VLbnBLaUdMQQ=="}, {"plaintext" : "ZUJlRGJQb0ZDYkhzcFd1dA=="}, {"plaintext" : "a3FWelJqSFhYZ1R5ekNUeA=="}, {"plaintext" : "R3J0VGpVSHpseXBobWpJSA=="}, {"plaintext" : "bXNFaFRZdUR0ZXdWb0J6RA=="}, {"plaintext" : "U0tXTFZ3a1lDV2dIV29RSA=="}, {"plaintext" : "UmdYUmZnSHJSRUdOZGtIWQ=="}, {"plaintext" : "dFpER1loRHlGT0VoSUJVUw=="}, {"plaintext" : "WGJnVGxla0VUTUhiTFlKUg=="}, {"plaintext" : "aXRNcWpUaGNnTGNST3ZBeQ=="}, {"plaintext" : "R2llWGNteU5NT3JWWG5WRQ=="}, {"plaintext" : "cEFVcVZlcHFQQ05ic0hhdA=="}, {"plaintext" : "eXVWeHdUQ25RQXJCemxNRA=="},{"plaintext" : "dGVldkV0R2ZodVV5Yk9zUA=="}, {"plaintext" : "SUVyeEdWUUF5U0pSY3hwTw=="}, {"plaintext" : "TXJjZkhsUnpWZkpOeWRhRQ=="}, {"plaintext" : "YWJnS013R3p2aWpCek1HUw=="}, {"plaintext" : "bHNIQXpOQWttd1RPUEdjbw=="}, {"plaintext" : "b0FDV1hlYmJJUUN4RUFQag=="}, {"plaintext" : "dVhQcEx0T0l1WFpvZm1xTg=="}, {"plaintext" : "Qk91ZGt4a2VLbnBLaUdMQQ=="}, {"plaintext" : "ZUJlRGJQb0ZDYkhzcFd1dA=="}, {"plaintext" : "a3FWelJqSFhYZ1R5ekNUeA=="}, {"plaintext" : "R3J0VGpVSHpseXBobWpJSA=="}, {"plaintext" : "bXNFaFRZdUR0ZXdWb0J6RA=="}, {"plaintext" : "U0tXTFZ3a1lDV2dIV29RSA=="}, {"plaintext" : "UmdYUmZnSHJSRUdOZGtIWQ=="}, {"plaintext" : "dFpER1loRHlGT0VoSUJVUw=="}, {"plaintext" : "WGJnVGxla0VUTUhiTFlKUg=="}, {"plaintext" : "aXRNcWpUaGNnTGNST3ZBeQ=="}, {"plaintext" : "R2llWGNteU5NT3JWWG5WRQ=="}, {"plaintext" : "cEFVcVZlcHFQQ05ic0hhdA=="}, {"plaintext" : "eXVWeHdUQ25RQXJCemxNRA=="},{"plaintext" : "dGVldkV0R2ZodVV5Yk9zUA=="}, {"plaintext" : "SUVyeEdWUUF5U0pSY3hwTw=="}, {"plaintext" : "TXJjZkhsUnpWZkpOeWRhRQ=="}, {"plaintext" : "YWJnS013R3p2aWpCek1HUw=="}, {"plaintext" : "bHNIQXpOQWttd1RPUEdjbw=="}, {"plaintext" : "b0FDV1hlYmJJUUN4RUFQag=="}, {"plaintext" : "dVhQcEx0T0l1WFpvZm1xTg=="}, {"plaintext" : "Qk91ZGt4a2VLbnBLaUdMQQ=="}, {"plaintext" : "ZUJlRGJQb0ZDYkhzcFd1dA=="}, {"plaintext" : "a3FWelJqSFhYZ1R5ekNUeA=="}, {"plaintext" : "R3J0VGpVSHpseXBobWpJSA=="}, {"plaintext" : "bXNFaFRZdUR0ZXdWb0J6RA=="}, {"plaintext" : "U0tXTFZ3a1lDV2dIV29RSA=="}, {"plaintext" : "UmdYUmZnSHJSRUdOZGtIWQ=="}, {"plaintext" : "dFpER1loRHlGT0VoSUJVUw=="}, {"plaintext" : "WGJnVGxla0VUTUhiTFlKUg=="}, {"plaintext" : "aXRNcWpUaGNnTGNST3ZBeQ=="}, {"plaintext" : "R2llWGNteU5NT3JWWG5WRQ=="}, {"plaintext" : "cEFVcVZlcHFQQ05ic0hhdA=="}, {"plaintext" : "eXVWeHdUQ25RQXJCemxNRA=="},{"plaintext" : "dGVldkV0R2ZodVV5Yk9zUA=="}, {"plaintext" : "SUVyeEdWUUF5U0pSY3hwTw=="}, {"plaintext" : "TXJjZkhsUnpWZkpOeWRhRQ=="}, {"plaintext" : "YWJnS013R3p2aWpCek1HUw=="}, {"plaintext" : "bHNIQXpOQWttd1RPUEdjbw=="}, {"plaintext" : "b0FDV1hlYmJJUUN4RUFQag=="}, {"plaintext" : "dVhQcEx0T0l1WFpvZm1xTg=="}, {"plaintext" : "Qk91ZGt4a2VLbnBLaUdMQQ=="}, {"plaintext" : "ZUJlRGJQb0ZDYkhzcFd1dA=="}, {"plaintext" : "a3FWelJqSFhYZ1R5ekNUeA=="}, {"plaintext" : "R3J0VGpVSHpseXBobWpJSA=="}, {"plaintext" : "bXNFaFRZdUR0ZXdWb0J6RA=="}, {"plaintext" : "U0tXTFZ3a1lDV2dIV29RSA=="}, {"plaintext" : "UmdYUmZnSHJSRUdOZGtIWQ=="}, {"plaintext" : "dFpER1loRHlGT0VoSUJVUw=="}, {"plaintext" : "WGJnVGxla0VUTUhiTFlKUg=="}, {"plaintext" : "aXRNcWpUaGNnTGNST3ZBeQ=="}, {"plaintext" : "R2llWGNteU5NT3JWWG5WRQ=="}, {"plaintext" : "cEFVcVZlcHFQQ05ic0hhdA=="}, {"plaintext" : "eXVWeHdUQ25RQXJCemxNRA=="},{"plaintext" : "dGVldkV0R2ZodVV5Yk9zUA=="}, {"plaintext" : "SUVyeEdWUUF5U0pSY3hwTw=="}, {"plaintext" : "TXJjZkhsUnpWZkpOeWRhRQ=="}, {"plaintext" : "YWJnS013R3p2aWpCek1HUw=="}, {"plaintext" : "bHNIQXpOQWttd1RPUEdjbw=="}, {"plaintext" : "b0FDV1hlYmJJUUN4RUFQag=="}, {"plaintext" : "dVhQcEx0T0l1WFpvZm1xTg=="}, {"plaintext" : "Qk91ZGt4a2VLbnBLaUdMQQ=="}, {"plaintext" : "ZUJlRGJQb0ZDYkhzcFd1dA=="}, {"plaintext" : "a3FWelJqSFhYZ1R5ekNUeA=="}, {"plaintext" : "R3J0VGpVSHpseXBobWpJSA=="}, {"plaintext" : "bXNFaFRZdUR0ZXdWb0J6RA=="}, {"plaintext" : "U0tXTFZ3a1lDV2dIV29RSA=="}, {"plaintext" : "UmdYUmZnSHJSRUdOZGtIWQ=="}, {"plaintext" : "dFpER1loRHlGT0VoSUJVUw=="}, {"plaintext" : "WGJnVGxla0VUTUhiTFlKUg=="}, {"plaintext" : "aXRNcWpUaGNnTGNST3ZBeQ=="}, {"plaintext" : "R2llWGNteU5NT3JWWG5WRQ=="}, {"plaintext" : "cEFVcVZlcHFQQ05ic0hhdA=="}, {"plaintext" : "eXVWeHdUQ25RQXJCemxNRA=="},{"plaintext" : "dGVldkV0R2ZodVV5Yk9zUA=="}, {"plaintext" : "SUVyeEdWUUF5U0pSY3hwTw=="}, {"plaintext" : "TXJjZkhsUnpWZkpOeWRhRQ=="}, {"plaintext" : "YWJnS013R3p2aWpCek1HUw=="}, {"plaintext" : "bHNIQXpOQWttd1RPUEdjbw=="}, {"plaintext" : "b0FDV1hlYmJJUUN4RUFQag=="}, {"plaintext" : "dVhQcEx0T0l1WFpvZm1xTg=="}, {"plaintext" : "Qk91ZGt4a2VLbnBLaUdMQQ=="}, {"plaintext" : "ZUJlRGJQb0ZDYkhzcFd1dA=="}, {"plaintext" : "a3FWelJqSFhYZ1R5ekNUeA=="}, {"plaintext" : "R3J0VGpVSHpseXBobWpJSA=="}, {"plaintext" : "bXNFaFRZdUR0ZXdWb0J6RA=="}, {"plaintext" : "U0tXTFZ3a1lDV2dIV29RSA=="}, {"plaintext" : "UmdYUmZnSHJSRUdOZGtIWQ=="}, {"plaintext" : "dFpER1loRHlGT0VoSUJVUw=="}, {"plaintext" : "WGJnVGxla0VUTUhiTFlKUg=="}, {"plaintext" : "aXRNcWpUaGNnTGNST3ZBeQ=="}, {"plaintext" : "R2llWGNteU5NT3JWWG5WRQ=="}, {"plaintext" : "cEFVcVZlcHFQQ05ic0hhdA=="}, {"plaintext" : "eXVWeHdUQ25RQXJCemxNRA=="},{"plaintext" : "dGVldkV0R2ZodVV5Yk9zUA=="}, {"plaintext" : "SUVyeEdWUUF5U0pSY3hwTw=="}, {"plaintext" : "TXJjZkhsUnpWZkpOeWRhRQ=="}, {"plaintext" : "YWJnS013R3p2aWpCek1HUw=="}, {"plaintext" : "bHNIQXpOQWttd1RPUEdjbw=="}, {"plaintext" : "b0FDV1hlYmJJUUN4RUFQag=="}, {"plaintext" : "dVhQcEx0T0l1WFpvZm1xTg=="}, {"plaintext" : "Qk91ZGt4a2VLbnBLaUdMQQ=="}, {"plaintext" : "ZUJlRGJQb0ZDYkhzcFd1dA=="}, {"plaintext" : "a3FWelJqSFhYZ1R5ekNUeA=="}, {"plaintext" : "R3J0VGpVSHpseXBobWpJSA=="}, {"plaintext" : "bXNFaFRZdUR0ZXdWb0J6RA=="}, {"plaintext" : "U0tXTFZ3a1lDV2dIV29RSA=="}, {"plaintext" : "UmdYUmZnSHJSRUdOZGtIWQ=="}, {"plaintext" : "dFpER1loRHlGT0VoSUJVUw=="}, {"plaintext" : "WGJnVGxla0VUTUhiTFlKUg=="}, {"plaintext" : "aXRNcWpUaGNnTGNST3ZBeQ=="}, {"plaintext" : "R2llWGNteU5NT3JWWG5WRQ=="}, {"plaintext" : "cEFVcVZlcHFQQ05ic0hhdA=="}, {"plaintext" : "eXVWeHdUQ25RQXJCemxNRA=="}, {"plaintext" : "dGVldkV0R2ZodVV5Yk9zUA=="}, {"plaintext" : "SUVyeEdWUUF5U0pSY3hwTw=="}, {"plaintext" : "TXJjZkhsUnpWZkpOeWRhRQ=="}, {"plaintext" : "YWJnS013R3p2aWpCek1HUw=="}, {"plaintext" : "bHNIQXpOQWttd1RPUEdjbw=="}, {"plaintext" : "b0FDV1hlYmJJUUN4RUFQag=="}, {"plaintext" : "dVhQcEx0T0l1WFpvZm1xTg=="}, {"plaintext" : "Qk91ZGt4a2VLbnBLaUdMQQ=="}, {"plaintext" : "ZUJlRGJQb0ZDYkhzcFd1dA=="}, {"plaintext" : "a3FWelJqSFhYZ1R5ekNUeA=="}, {"plaintext" : "R3J0VGpVSHpseXBobWpJSA=="}, {"plaintext" : "bXNFaFRZdUR0ZXdWb0J6RA=="}, {"plaintext" : "U0tXTFZ3a1lDV2dIV29RSA=="}, {"plaintext" : "UmdYUmZnSHJSRUdOZGtIWQ=="}, {"plaintext" : "dFpER1loRHlGT0VoSUJVUw=="}, {"plaintext" : "WGJnVGxla0VUTUhiTFlKUg=="}, {"plaintext" : "aXRNcWpUaGNnTGNST3ZBeQ=="}, {"plaintext" : "R2llWGNteU5NT3JWWG5WRQ=="}, {"plaintext" : "cEFVcVZlcHFQQ05ic0hhdA=="}, {"plaintext" : "eXVWeHdUQ25RQXJCemxNRA=="},{"plaintext" : "dGVldkV0R2ZodVV5Yk9zUA=="}, {"plaintext" : "SUVyeEdWUUF5U0pSY3hwTw=="}, {"plaintext" : "TXJjZkhsUnpWZkpOeWRhRQ=="}, {"plaintext" : "YWJnS013R3p2aWpCek1HUw=="}, {"plaintext" : "bHNIQXpOQWttd1RPUEdjbw=="}, {"plaintext" : "b0FDV1hlYmJJUUN4RUFQag=="}, {"plaintext" : "dVhQcEx0T0l1WFpvZm1xTg=="}, {"plaintext" : "Qk91ZGt4a2VLbnBLaUdMQQ=="}, {"plaintext" : "ZUJlRGJQb0ZDYkhzcFd1dA=="}, {"plaintext" : "a3FWelJqSFhYZ1R5ekNUeA=="}, {"plaintext" : "R3J0VGpVSHpseXBobWpJSA=="}, {"plaintext" : "bXNFaFRZdUR0ZXdWb0J6RA=="}, {"plaintext" : "U0tXTFZ3a1lDV2dIV29RSA=="}, {"plaintext" : "UmdYUmZnSHJSRUdOZGtIWQ=="}, {"plaintext" : "dFpER1loRHlGT0VoSUJVUw=="}, {"plaintext" : "WGJnVGxla0VUTUhiTFlKUg=="}, {"plaintext" : "aXRNcWpUaGNnTGNST3ZBeQ=="}, {"plaintext" : "R2llWGNteU5NT3JWWG5WRQ=="}, {"plaintext" : "cEFVcVZlcHFQQ05ic0hhdA=="}, {"plaintext" : "eXVWeHdUQ25RQXJCemxNRA=="},{"plaintext" : "dGVldkV0R2ZodVV5Yk9zUA=="}, {"plaintext" : "SUVyeEdWUUF5U0pSY3hwTw=="}, {"plaintext" : "TXJjZkhsUnpWZkpOeWRhRQ=="}, {"plaintext" : "YWJnS013R3p2aWpCek1HUw=="}, {"plaintext" : "bHNIQXpOQWttd1RPUEdjbw=="}, {"plaintext" : "b0FDV1hlYmJJUUN4RUFQag=="}, {"plaintext" : "dVhQcEx0T0l1WFpvZm1xTg=="}, {"plaintext" : "Qk91ZGt4a2VLbnBLaUdMQQ=="}, {"plaintext" : "ZUJlRGJQb0ZDYkhzcFd1dA=="}, {"plaintext" : "a3FWelJqSFhYZ1R5ekNUeA=="}, {"plaintext" : "R3J0VGpVSHpseXBobWpJSA=="}, {"plaintext" : "bXNFaFRZdUR0ZXdWb0J6RA=="}, {"plaintext" : "U0tXTFZ3a1lDV2dIV29RSA=="}, {"plaintext" : "UmdYUmZnSHJSRUdOZGtIWQ=="}, {"plaintext" : "dFpER1loRHlGT0VoSUJVUw=="}, {"plaintext" : "WGJnVGxla0VUTUhiTFlKUg=="}, {"plaintext" : "aXRNcWpUaGNnTGNST3ZBeQ=="}, {"plaintext" : "R2llWGNteU5NT3JWWG5WRQ=="}, {"plaintext" : "cEFVcVZlcHFQQ05ic0hhdA=="}, {"plaintext" : "eXVWeHdUQ25RQXJCemxNRA=="},{"plaintext" : "dGVldkV0R2ZodVV5Yk9zUA=="}, {"plaintext" : "SUVyeEdWUUF5U0pSY3hwTw=="}, {"plaintext" : "TXJjZkhsUnpWZkpOeWRhRQ=="}, {"plaintext" : "YWJnS013R3p2aWpCek1HUw=="}, {"plaintext" : "bHNIQXpOQWttd1RPUEdjbw=="}, {"plaintext" : "b0FDV1hlYmJJUUN4RUFQag=="}, {"plaintext" : "dVhQcEx0T0l1WFpvZm1xTg=="}, {"plaintext" : "Qk91ZGt4a2VLbnBLaUdMQQ=="}, {"plaintext" : "ZUJlRGJQb0ZDYkhzcFd1dA=="}, {"plaintext" : "a3FWelJqSFhYZ1R5ekNUeA=="}, {"plaintext" : "R3J0VGpVSHpseXBobWpJSA=="}, {"plaintext" : "bXNFaFRZdUR0ZXdWb0J6RA=="}, {"plaintext" : "U0tXTFZ3a1lDV2dIV29RSA=="}, {"plaintext" : "UmdYUmZnSHJSRUdOZGtIWQ=="}, {"plaintext" : "dFpER1loRHlGT0VoSUJVUw=="}, {"plaintext" : "WGJnVGxla0VUTUhiTFlKUg=="}, {"plaintext" : "aXRNcWpUaGNnTGNST3ZBeQ=="}, {"plaintext" : "R2llWGNteU5NT3JWWG5WRQ=="}, {"plaintext" : "cEFVcVZlcHFQQ05ic0hhdA=="}, {"plaintext" : "eXVWeHdUQ25RQXJCemxNRA=="},{"plaintext" : "dGVldkV0R2ZodVV5Yk9zUA=="}, {"plaintext" : "SUVyeEdWUUF5U0pSY3hwTw=="}, {"plaintext" : "TXJjZkhsUnpWZkpOeWRhRQ=="}, {"plaintext" : "YWJnS013R3p2aWpCek1HUw=="}, {"plaintext" : "bHNIQXpOQWttd1RPUEdjbw=="}, {"plaintext" : "b0FDV1hlYmJJUUN4RUFQag=="}, {"plaintext" : "dVhQcEx0T0l1WFpvZm1xTg=="}, {"plaintext" : "Qk91ZGt4a2VLbnBLaUdMQQ=="}, {"plaintext" : "ZUJlRGJQb0ZDYkhzcFd1dA=="}, {"plaintext" : "a3FWelJqSFhYZ1R5ekNUeA=="}, {"plaintext" : "R3J0VGpVSHpseXBobWpJSA=="}, {"plaintext" : "bXNFaFRZdUR0ZXdWb0J6RA=="}, {"plaintext" : "U0tXTFZ3a1lDV2dIV29RSA=="}, {"plaintext" : "UmdYUmZnSHJSRUdOZGtIWQ=="}, {"plaintext" : "dFpER1loRHlGT0VoSUJVUw=="}, {"plaintext" : "WGJnVGxla0VUTUhiTFlKUg=="}, {"plaintext" : "aXRNcWpUaGNnTGNST3ZBeQ=="}, {"plaintext" : "R2llWGNteU5NT3JWWG5WRQ=="}, {"plaintext" : "cEFVcVZlcHFQQ05ic0hhdA=="}, {"plaintext" : "eXVWeHdUQ25RQXJCemxNRA=="},{"plaintext" : "dGVldkV0R2ZodVV5Yk9zUA=="}, {"plaintext" : "SUVyeEdWUUF5U0pSY3hwTw=="}, {"plaintext" : "TXJjZkhsUnpWZkpOeWRhRQ=="}, {"plaintext" : "YWJnS013R3p2aWpCek1HUw=="}, {"plaintext" : "bHNIQXpOQWttd1RPUEdjbw=="}, {"plaintext" : "b0FDV1hlYmJJUUN4RUFQag=="}, {"plaintext" : "dVhQcEx0T0l1WFpvZm1xTg=="}, {"plaintext" : "Qk91ZGt4a2VLbnBLaUdMQQ=="}, {"plaintext" : "ZUJlRGJQb0ZDYkhzcFd1dA=="}, {"plaintext" : "a3FWelJqSFhYZ1R5ekNUeA=="}, {"plaintext" : "R3J0VGpVSHpseXBobWpJSA=="}, {"plaintext" : "bXNFaFRZdUR0ZXdWb0J6RA=="}, {"plaintext" : "U0tXTFZ3a1lDV2dIV29RSA=="}, {"plaintext" : "UmdYUmZnSHJSRUdOZGtIWQ=="}, {"plaintext" : "dFpER1loRHlGT0VoSUJVUw=="}, {"plaintext" : "WGJnVGxla0VUTUhiTFlKUg=="}, {"plaintext" : "aXRNcWpUaGNnTGNST3ZBeQ=="}, {"plaintext" : "R2llWGNteU5NT3JWWG5WRQ=="}, {"plaintext" : "cEFVcVZlcHFQQ05ic0hhdA=="}, {"plaintext" : "eXVWeHdUQ25RQXJCemxNRA=="},{"plaintext" : "dGVldkV0R2ZodVV5Yk9zUA=="}, {"plaintext" : "SUVyeEdWUUF5U0pSY3hwTw=="}, {"plaintext" : "TXJjZkhsUnpWZkpOeWRhRQ=="}, {"plaintext" : "YWJnS013R3p2aWpCek1HUw=="}, {"plaintext" : "bHNIQXpOQWttd1RPUEdjbw=="}, {"plaintext" : "b0FDV1hlYmJJUUN4RUFQag=="}, {"plaintext" : "dVhQcEx0T0l1WFpvZm1xTg=="}, {"plaintext" : "Qk91ZGt4a2VLbnBLaUdMQQ=="}, {"plaintext" : "ZUJlRGJQb0ZDYkhzcFd1dA=="}, {"plaintext" : "a3FWelJqSFhYZ1R5ekNUeA=="}, {"plaintext" : "R3J0VGpVSHpseXBobWpJSA=="}, {"plaintext" : "bXNFaFRZdUR0ZXdWb0J6RA=="}, {"plaintext" : "U0tXTFZ3a1lDV2dIV29RSA=="}, {"plaintext" : "UmdYUmZnSHJSRUdOZGtIWQ=="}, {"plaintext" : "dFpER1loRHlGT0VoSUJVUw=="}, {"plaintext" : "WGJnVGxla0VUTUhiTFlKUg=="}, {"plaintext" : "aXRNcWpUaGNnTGNST3ZBeQ=="}, {"plaintext" : "R2llWGNteU5NT3JWWG5WRQ=="}, {"plaintext" : "cEFVcVZlcHFQQ05ic0hhdA=="}, {"plaintext" : "eXVWeHdUQ25RQXJCemxNRA=="},{"plaintext" : "dGVldkV0R2ZodVV5Yk9zUA=="}, {"plaintext" : "SUVyeEdWUUF5U0pSY3hwTw=="}, {"plaintext" : "TXJjZkhsUnpWZkpOeWRhRQ=="}, {"plaintext" : "YWJnS013R3p2aWpCek1HUw=="}, {"plaintext" : "bHNIQXpOQWttd1RPUEdjbw=="}, {"plaintext" : "b0FDV1hlYmJJUUN4RUFQag=="}, {"plaintext" : "dVhQcEx0T0l1WFpvZm1xTg=="}, {"plaintext" : "Qk91ZGt4a2VLbnBLaUdMQQ=="}, {"plaintext" : "ZUJlRGJQb0ZDYkhzcFd1dA=="}, {"plaintext" : "a3FWelJqSFhYZ1R5ekNUeA=="}, {"plaintext" : "R3J0VGpVSHpseXBobWpJSA=="}, {"plaintext" : "bXNFaFRZdUR0ZXdWb0J6RA=="}, {"plaintext" : "U0tXTFZ3a1lDV2dIV29RSA=="}, {"plaintext" : "UmdYUmZnSHJSRUdOZGtIWQ=="}, {"plaintext" : "dFpER1loRHlGT0VoSUJVUw=="}, {"plaintext" : "WGJnVGxla0VUTUhiTFlKUg=="}, {"plaintext" : "aXRNcWpUaGNnTGNST3ZBeQ=="}, {"plaintext" : "R2llWGNteU5NT3JWWG5WRQ=="}, {"plaintext" : "cEFVcVZlcHFQQ05ic0hhdA=="}, {"plaintext" : "eXVWeHdUQ25RQXJCemxNRA=="}]}'
wrk.headers["Content-Type"] = "application/json"

local counter = 1
local threads = {}

-- print lots of info, this can slow down due to the verbosity of traffic
printDebug = false

function setup(thread)
   thread:set("id", counter)
   table.insert(threads, thread)
   counter = counter + 1
end

function os.capture(cmd, raw)
  local f = assert(io.popen(cmd, 'r'))
  local s = assert(f:read('*a'))
  f:close()
  if raw then return s end
  s = string.gsub(s, '^%s+', '')
  s = string.gsub(s, '%s+$', '')
  s = string.gsub(s, '[\n\r]+', ' ')
  return s
end

function RandomVariable(length)
	local res = ""
	for i = 1, length do
		res = res .. string.char(math.random(97, 122))
	end
	return res
end

-- char map for enc to base64 function
local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'

-- encode base64 function
function enc(data)
    return ((data:gsub('.', function(x) 
        local r,b='',x:byte()
        for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0') end
        return r;
    end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
        if (#x < 6) then return '' end
        local c=0
        for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
        return b:sub(c+1,c+1)
    end)..({ '', '==', '=' })[#data%3+1])
end


function init(args)
	require("check_envvars")
	check_envvars()

   if args[1] == nil then
      num_secrets = 1000
   else
      num_secrets = tonumber(args[1])
   end
   print("Number of transit requests to encrypt is: " .. num_secrets)
   requests  = 0
   responses = 0
   method = "POST"
   path = "/v1/transitTest/encrypt/test"
   body = ""
   local msg = "thread %d created"
   print(msg:format(id))	
end

function request()
	-- print("starting request " .. requests)
	-- can comment path and body out as we set them via init above
	-- path = ""
	body = '{"plaintext":"' .. enc(RandomVariable(30)) .. '" }'
	-- body = '{"plaintext":"YXZidnF2ZWd4aWNqeGFydG9kZGFtcm53ZGh3dHNx" }'
	requests = requests + 1
	while num_secrets > responses do
    if printDebug then
      print(path)
      print(wrk.headers)
      print(body)
    end
		return wrk.format(method, path, wrk.headers, body)
	end
end

function response(status, headers, body)
	responses = responses + 1
	if printDebug then
    print("Thread " .. id .. " - starting response " .. responses)
  end
	-- if non-200 returned, print for debugging
	if status ~= 200 then
		print(headers)
		print(body)
		print(status)
	end
	if printDebug then
  	print(body)
  end
	if responses == num_secrets then
		print("done, now summarize results")
		-- wrk.thread:stop()
		-- os.exit()
	end
end

done = function(summary, latency, requests)
	require("check_audit")
	audit_enabled = check_audit()

	io.write("\nJSON Output:\n")
   io.write("{\n")
   io.write(string.format("\t\"requests\": %d,\n", summary.requests))
   io.write(string.format("\t\"duration_in_microseconds\": %0.2f,\n", summary.duration))
   io.write(string.format("\t\"bytes\": %d,\n", summary.bytes))
   io.write(string.format("\t\"requests_per_sec\": %0.2f,\n", (summary.requests/summary.duration)*1e6))
   io.write(string.format("\t\"bytes_transfer_per_sec\": %0.2f,\n", (summary.bytes/summary.duration)*1e6))

   io.write("\t\"latency_distribution\": [\n")
   for _, p in pairs({ 50, 75, 90, 99, 99.9, 99.99, 99.999, 100 }) do
      io.write("\t\t{\n")
      n = latency:percentile(p)
      io.write(string.format("\t\t\t\"percentile\": %g,\n\t\t\t\"latency_in_microseconds\": %d\n", p, n))
      if p == 100 then 
          io.write("\t\t}\n")
      else 
          io.write("\t\t},\n")
      end
   end
   io.write("\t]\n}\n")
end

