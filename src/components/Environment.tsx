import React from 'react';
import {Card, Paragraph, XStack, Button, H3, View} from 'tamagui';

function Environment(): JSX.Element {
  return (
    <Card size="$4" margin="$4">
      <Card.Header padded paddingBottom="$2">
        <H3 selectable={false} color="$green10">
          Silent
        </H3>
        <Paragraph selectable={false}>
          Silent mode automatically accepts all incoming / outgoing requests
          until you verify them
        </Paragraph>
      </Card.Header>

      <Card.Footer padded paddingTop="$2">
        <XStack flex={1} />
        <Button borderRadius="$10" color="$green10">
          Switch to secure mode
        </Button>
      </Card.Footer>

      <Card.Background>
        <View />
      </Card.Background>
    </Card>
  );
}

export default Environment;
