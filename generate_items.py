from enum import Enum
import json
import os
from typing import Optional
from pydantic import BaseModel


class Interactivity(str, Enum):
    full = "full"
    exhibit = "exhibit"


class APClass(str, Enum):
    filler = "Filler"
    progression = "Progression"
    useful = "Useful"
    trap = "Trap"
    deprioritized = "Deprioritized"


class Version(str, Enum):
    base = "Base"


class ItemsData(BaseModel):
    name: str
    ap_classification: APClass
    version: Version
    quantity: int
    id: int


class ItemType (str, Enum):
    toggle = "toggle"
    progressive = "progressive"
    consumable = "consumable"
    progressive_toggle = "progressive toggle"


# Load Source of Truth
items_SOT_path = os.path.join(
    os.path.dirname(__file__), "worlds", "planetzoo", "data", "items.json")
with open(items_SOT_path) as json_file:
    items_json_data = json.load(json_file)
    loop_list = [ItemsData.model_validate(
        loopstuff) for loopstuff in items_json_data]

items_data = ItemsData(**items_json_data)

# Load thumbnail images, in order to get strings from them

thumbnails_path = os.path.join(
    os.path.dirname(__file__), "images", "thumbnails"
)

thumbnail_names = os.listdir(thumbnails_path)
enumerate(thumbnail_names)

list_of_permits: list[ItemsData] = sorted(
    (item for item in loop_list if
    "Permit" in item.name),
    key=lambda item: item.name
)
enumerate(list_of_permits)


# General Item formation


class ItemFormation (BaseModel):
    class StageDict (BaseModel):
        name: str
        codes: str
        img: str
        img_mods: str

    name: str
    type: ItemType
    img: str
    code: str
    stages: Optional[list[StageDict]] = None

    def __init__(self, name, type, img, codes, stages, index: int):
        self.name = name
        self.type = self.TypeCreation(type)
        self.img = self.ImageCreation(img, index)
        self.code = codes
        self.stages = stages

    def ImageCreation(self, name, index: int) -> str:
        if "Permit" in name:
            image_address = thumbnail_names[index]
        return image_address

    def TypeCreation(self, type_string):
        item_type = ItemType.toggle
        match type_string:
            case "toggle":
                item_type = ItemType.toggle
            case "progressive":
                item_type = ItemType.progressive
            case "consumable":
                item_type = ItemType.consumable
            case "progressive toggle":
                item_type = ItemType.progressive_toggle
        return item_type


poptracker_items: list[ItemFormation] = []


Planet-Zoo-Poptracker\images\thumbnails\xxxx".png"
#   {
#         "name": "Boulder Badge",
#         "type": "toggle",
#         "img": "images/items/boulder.png",
#         "codes": "boulder,badge"
#     },
#  {
#         "name": "HM05 Flash",
#         "type": "progressive_toggle",
#         "img": "images/items/hm_normal",
#         "codes": "flash",
#         "stages": [
#             {
#                 "name": "HM05 Flash",
#                 "codes": "flash,flash_noextra",
#                 "img": "images/items/hm_normal.png"
#             },
#             {
#                 "name": "HM05 Flash - Extra: Boulder Badge",
#                 "codes": "flash,flash_boulder",
#                 "img": "images/items/hm_normal.png",
#                 "img_mods": "overlay|images/overlays/boulder.png"
#             },


