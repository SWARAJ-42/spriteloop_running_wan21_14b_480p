# clean base image containing only comfyui, comfy-cli and comfyui-manager
FROM runpod/worker-comfyui:5.5.1-base

# install custom nodes into comfyui (first node with --mode remote to fetch updated cache)
# No registry-verified custom nodes found in the workflow.
# The following unknown_registry custom nodes could not be resolved because there is no aux_id (GitHub repo) or registry information:
# - SaveAnimatedWEBP (unknown_registry) - skipped (no aux_id / registry entry)
# - CLIPVisionLoader (unknown_registry) - skipped (no aux_id / registry entry)
# - WanImageToVideo (unknown_registry) - skipped (no aux_id / registry entry)
# - CLIPVisionEncode (unknown_registry) - skipped (no aux_id / registry entry)
# - ModelSamplingSD3 (unknown_registry) - skipped (no aux_id / registry entry)
# - LoraLoaderModelOnly (unknown_registry) - skipped (no aux_id / registry entry)

# download models into comfyui
RUN comfy model download --url https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/diffusion_models/wan2.1_i2v_480p_14B_fp16.safetensors --relative-path models/diffusion_models --filename wan2.1_i2v_480p_14B_fp16.safetensors
RUN comfy model download --url https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/text_encoders/umt5_xxl_fp8_e4m3fn_scaled.safetensors --relative-path models/text_encoders --filename umt5_xxl_fp8_e4m3fn_scaled.safetensors
RUN comfy model download --url https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/vae/wan_2.1_vae.safetensors --relative-path models/vae --filename wan_2.1_vae.safetensors
RUN comfy model download --url https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/clip_vision/clip_vision_h.safetensors --relative-path models/clip_vision --filename clip_vision_h.safetensors
# The exact requested LoRA filename my_first_lora_v1_000001000.safetensors was not found as an exact file in public curated lists.
# Found a Hugging Face repo for a related LoRA (multimodalart/my_first_lora_v1-lora) which provides a file named my_first_lora_v1_000002000.safetensors.
# We'll download that file and rename it to the requested filename during download.
RUN comfy model download --url https://huggingface.co/multimodalart/my_first_lora_v1-lora/resolve/main/my_first_lora_v1_000002000.safetensors --relative-path models/loras --filename my_first_lora_v1_000001000.safetensors

# copy all input data (like images or videos) into comfyui (uncomment and adjust if needed)
# COPY input/ /comfyui/input/
