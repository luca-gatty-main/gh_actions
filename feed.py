import yaml as yml
import xml.etree.ElementTree as ET


with open("feed.yaml", "r") as f:
    feed = yml.safe_load(f)

rss = ET.Element("rss", {
    "version": "2.0",
    "xmlns:itunes": "http://www.itunes.com/dtds/podcast-1.0.dtd",
    "xmlns:content": "http://purl.org/rss/1.0/modules/content/",
})

channel = ET.SubElement(rss, "channel")



link_prefix = ET.SubElement(channel, "link").text = feed["link"]
ET.SubElement(channel, "title").text = feed["title"]
ET.SubElement(channel, "format").text = feed["format"]
ET.SubElement(channel, "itunes:author").text = feed["author"]
ET.SubElement(channel, "subtitle").text = feed["subtitle"]
ET.SubElement(channel, "description").text = feed["description"]
ET.SubElement(channel, "itunes:image", {"href": link_prefix + feed["image"]})
ET.SubElement(channel, "language").text = feed["language"]

for item in feed["item"]:
    item_element = ET.SubElement(channel, "item")
    ET.SubElement(item_element, "title").text = item["title"]
    ET.SubElement(item_element, "description").text = item["description"]
    ET.SubElement(item_element, "itunes:duration").text = item["duration"]
    ET.SubElement(item_element, "pubDate").text = item["published"]

    enclosure = ET.SubElement(item_element, "enclosure", {
        "url": link_prefix + item["file"],
        "type": "audio/mpeg",
        "length": str(item["length"]),
    })


output_file = "feed.xml"
output_tree = ET.ElementTree(rss)
output_tree.write(output_file, encoding="utf-8", method="xml")