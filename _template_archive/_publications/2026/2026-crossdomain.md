---
title:          "Cross Embodiment Offline RL (DOING PROJECT)"
date:           2026-08-01 00:01:00 +0800
selected:       true
# pub:            "DOING"
# pub_date:       "2026"
abstract: >-
  We want to answer: How to utilize heterogeneous data efficiently, and how to measure transferability across different domains? 
  We have two insights:

  1. Transferability between two MDPs: This requires hierarchical abstraction of fine-grained states and actions. The higher the level of abstraction, the greater the transferability, but at the cost of information loss.

  2. Self-supervised latent space construction: Using the same task semantic as an anchor, a bisimulation metric is employed to formulate a regularization loss for training the latent space, which is then optimized iteratively via dynamic programming.

# cover: /assets/images/covers/actsafeguard2.png
authors:
  - Jianming Ma
  - Weijun Chen

# links:
#   Paper: https://arxiv.org/abs/2606.13400
#   PDF: https://arxiv.org/pdf/2606.13400
#   Code: https://github.com/MJianM/PolyFlow
---
