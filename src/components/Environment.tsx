import React from 'react';
import {Card, Paragraph, XStack, Button, H2, View} from 'tamagui';

function Environment(): JSX.Element {
  return (
    <Card size="$4" margin="$4">
      <Card.Header padded>
        <H2 selectable={false}>Silent</H2>
        <Paragraph selectable={false}>
          Silent mode automatically accepts all incoming / outgoing requests
          until you verify them
        </Paragraph>
      </Card.Header>

      <Card.Footer padded>
        <XStack flex={1} />
        <Button borderRadius="$10">Switch to secure mode</Button>
      </Card.Footer>

      <Card.Background>
        <View />
      </Card.Background>
    </Card>
  );
}

export default Environment;
