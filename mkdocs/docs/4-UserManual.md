# User manual

Newsku is fairly straight forward to use but here's how to get started

## Add feeds

Once you've created your account, go to the settings (top right icon on the screen) and add or import your preferred RSS
feeds.

![image](feeds.png)

## Set up AI preferences

By default, the AI model will decide what is important news on its own. You can steer its article scoring by setting
your preferences in the "General" tab.

Note that the change will only apply to future articles.

![image](general.png)

## Customizing layout

With Newsku you can design your home page with building block. Go to Settings > Layout then you can just drag and drop
the blocks as you wish.
The only limit here is that you need to end your layout with a "Dynamic article count" block.

![type:video](./layout.webm)

### Block types

| Block type          | Number of articles | Layout builder                                  | In feed                                 | 
|---------------------|--------------------|-------------------------------------------------|-----------------------------------------|
| Headline            | 1                  | ![image](./blocks/headline_preview.png)         | ![image](./blocks/headline.png)         |
| Headline on picture | 1                  | ![image](./blocks/headline_picture_preview.png) | ![image](./blocks/headline_picture.png) |
| Top stories         | 4                  | ![image](./blocks/top_stories_preview.png)      | ![image](./blocks/top_stories.png)      |
| Big grid            | flexible           | ![image](./blocks/big_grid_preview.png)         | ![image](./blocks/big_grid.png)         |
| Big picture grid    | flexible           | ![image](./blocks/big_grid_picture_preview.png) | ![image](./blocks/big_grid_picture.png) |
| Small grid          | flexible           | ![image](./blocks/small_grid_preview.png)       | ![image](./blocks/small_grid.png)       |
| List                | flexible           | ![image](./blocks/single_item_row_preview.png)  | ![image](./blocks/single_item_row.png)  |



## API keys and AI assistants

You can create API keys in Settings > API keys to access your data programmatically, or to connect an AI assistant to
Newsku through its MCP server so it can read your news and mark articles as read. See the [API](3-API.md) page for
details.
